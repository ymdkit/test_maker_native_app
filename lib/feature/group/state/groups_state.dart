import 'dart:async';

import 'package:fpdart/fpdart.dart' hide Group;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/group/repository/group_repository.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

typedef GroupsState = AppAsyncState<List<Group>>;

final groupsProvider =
    StateNotifierProvider.autoDispose<GroupsStateNotifier, GroupsState>((ref) {
  final _ = ref.watch(accountStateProvider);
  return GroupsStateNotifier(
    groupRepository: ref.watch(groupRepositoryProvider),
  );
});

class GroupsStateNotifier extends StateNotifier<GroupsState> {
  GroupsStateNotifier({
    required this.groupRepository,
  }) : super(const GroupsState.loading()) {
    setupGroups();
  }

  final GroupRepository groupRepository;

  Future<void> setupGroups() async {
    state = const GroupsState.loading();
    final result = await groupRepository.getGroups();
    result.match(
      (l) => state = GroupsState.failure(exception: l),
      (r) => state = GroupsState.success(value: r),
    );
  }

  Future<Either<AppException, Group>> addGroup({
    required String title,
    required AppThemeColor color,
  }) async {
    final tasks = groupRepository
        .addGroup(
          title: title,
          color: color,
        )
        .flatMap(groupRepository.joinGroup)
        .flatMap(
          (group) => TaskEither<AppException, Group>(
            () async {
              state.maybeWhen(
                success: (groups) => state = GroupsState.success(
                  value: [...groups, group],
                ),
                orElse: () {},
              );
              return right(group);
            },
          ),
        );

    return tasks.run();
  }

  Future<Either<AppException, void>> updateGroup({
    required Group currentGroup,
    required String title,
    required AppThemeColor color,
  }) async {
    final updatedGroup = currentGroup.copyWith(
      title: title,
      color: color,
    );
    final result = await groupRepository.updateGroup(updatedGroup);

    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (groups) => state = GroupsState.success(
            value: groups.map(
              (e) {
                if (e.groupId == updatedGroup.groupId) {
                  return updatedGroup;
                } else {
                  return e;
                }
              },
            ).toList(),
          ),
          orElse: () {},
        );
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> deleteGroup(Group group) async {
    final result = await groupRepository.deleteGroup(group);
    //TODO: 自分自身の退出
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (groups) {
            state = GroupsState.success(
              value: groups.where((e) => e.groupId != group.groupId).toList(),
            );
          },
          orElse: () {},
        );

        return right(r);
      },
    );
  }
}
