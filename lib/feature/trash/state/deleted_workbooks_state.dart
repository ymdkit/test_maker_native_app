import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final deletedWorkbooksProvider =
    StateNotifierProvider.autoDispose<WorkbooksStateNotifier, WorkbooksState>(
  (ref) => WorkbooksStateNotifier(
    workbookRepository: ref.watch(workbookRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateDeletedWorkbookStream:
        ref.watch(onMutateDeletedWorkbookStreamProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<WorkbooksState> {
  WorkbooksStateNotifier({
    required this.workbookRepository,
    required this.onMutateDeletedWorkbookStream,
    required StreamController<Workbook> onMutateWorkbookStream,
  }) : super(const WorkbooksState.loading()) {
    onMutateWorkbookSubscription = onMutateWorkbookStream.stream.listen(
      (workbook) async {
        final result = await workbookRepository.getDeletedWorkbooks();
        result.match(
          (l) => state = WorkbooksState.failure(exception: l),
          (r) => state = WorkbooksState.success(workbooks: r),
        );
      },
    );
  }

  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateDeletedWorkbookStream;
  late final StreamSubscription<Workbook> onMutateWorkbookSubscription;

  Future<Either<AppException, void>> restoreWorkbook(Workbook workbook) async =>
      await state.maybeWhen(
        success: (workbooks) async {
          final result = await workbookRepository.restoreWorkbook(workbook);

          return result.match(
            (l) => left(l),
            (r) {
              state = WorkbooksState.success(
                workbooks: workbooks
                    .where(
                      (e) => e.workbookId != workbook.workbookId,
                    )
                    .toList(),
              );
              return right(r);
            },
          );
        },
        orElse: () => right(null),
      );

  Future<Either<AppException, void>> destroyWorkbooks() async =>
      await state.maybeWhen(
        success: (workbooks) async {
          final result = await workbookRepository.destroyWorkbooks(workbooks);

          return result.match(
            (l) => left(l),
            (r) {
              state = const WorkbooksState.success(workbooks: []);
              return right(r);
            },
          );
        },
        orElse: () => right(null),
      );

  @override
  void dispose() {
    onMutateWorkbookSubscription.cancel();
    super.dispose();
  }
}

final onMutateDeletedWorkbookStreamProvider = Provider(
  (ref) => StreamController<Workbook>.broadcast(),
);
