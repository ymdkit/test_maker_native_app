import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/group/repository/group_repository.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

typedef GroupWorkbooksState = AppAsyncState<List<Workbook>>;

final groupWorkbooksStateProvider = StateNotifierProvider.autoDispose
    .family<GroupWorkbooksStateNotifier, GroupWorkbooksState, String>(
  (ref, groupId) => GroupWorkbooksStateNotifier(
    groupId: groupId,
    groupRepository: ref.watch(groupRepositoryProvider),
    ref: ref,
  ),
);

class GroupWorkbooksStateNotifier extends StateNotifier<GroupWorkbooksState> {
  GroupWorkbooksStateNotifier({
    required this.groupId,
    required this.groupRepository,
    required this.ref,
  }) : super(const GroupWorkbooksState.loading()) {
    _setup();
  }

  final String groupId;
  final GroupRepository groupRepository;
  final Ref ref;

  Future<void> _setup() async {
    final result = await groupRepository.getGroupWorkbooks(groupId: groupId);

    return result.fold(
      (l) => state = GroupWorkbooksState.failure(exception: l),
      (r) => state = GroupWorkbooksState.success(value: r),
    );
  }

  Future<Either<AppException, void>> addWorkbookToGroup({
    required Workbook workbook,
  }) async {
    final workbookRepository = ref.read(
      workbookRepositoryProvider(workbook.location),
    );
    final result = await workbookRepository.linkToGroup(
      groupId: groupId,
      workbook: workbook,
    );

    return result.fold(
      (l) => left(l),
      (_) {
        state.maybeWhen(
          success: (workbooks) {
            state = GroupWorkbooksState.success(
              value: [workbook, ...workbooks],
            );
          },
          orElse: () {},
        );
        return right(null);
      },
    );
  }

  Future<Either<AppException, void>> removeWorkbookFromGroup({
    required Workbook workbook,
  }) async {
    final result = await groupRepository.unLinkGroupWorkbook(
      groupId: groupId,
      workbookId: workbook.workbookId,
    );

    return result.fold(
      (l) => left(l),
      (_) {
        state.maybeWhen(
          success: (workbooks) {
            state = GroupWorkbooksState.success(
              value: workbooks
                  .where((w) => w.workbookId != workbook.workbookId)
                  .toList(),
            );
          },
          orElse: () {},
        );
        return right(null);
      },
    );
  }
}
