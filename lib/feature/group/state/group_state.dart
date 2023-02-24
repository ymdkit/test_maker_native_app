import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/group/state/groups_state.dart';

part 'group_state.g.dart';

@riverpod
Group group(GroupRef ref, String groupId) {
  final groupsState = ref.watch(groupsProvider);
  return groupsState.maybeWhen(
    orElse: () => Group.empty(),
    success: (groups) =>
        groups.firstWhereOrNull((e) => e.groupId == groupId) ?? Group.empty(),
  );
}
