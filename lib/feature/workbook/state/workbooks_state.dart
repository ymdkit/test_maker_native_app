import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

part 'workbooks_state.freezed.dart';

@freezed
class WorkbooksState with _$WorkbooksState {
  const factory WorkbooksState.loading() = WorkbooksState_Loading;
  const factory WorkbooksState.success({
    required List<Workbook> workbooks,
  }) = WorkbooksState_Success;
  const factory WorkbooksState.failure({
    required AppException exception,
  }) = WorkbooksState_Failure;
}

final workbooksProvider = StateNotifierProvider.autoDispose
    .family<WorkbooksStateNotifier, WorkbooksState, String?>(
  (ref, folderId) => WorkbooksStateNotifier(
    folderId: folderId,
    workbookRepository: ref.watch(workbookRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    onMutateDeletedWorkbookStream:
        ref.watch(onMutateDeletedWorkbookStreamProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<WorkbooksState> {
  WorkbooksStateNotifier({
    required this.folderId,
    required this.workbookRepository,
    required this.onMutateWorkbookStream,
    required StreamController<Question> onMutateQuestionStream,
    required StreamController<Workbook> onMutateDeletedWorkbookStream,
  }) : super(const WorkbooksState.loading()) {
    setupWorkbooks();
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (_) => setupWorkbooks(),
    );
    onMutateDeletedWorkbookSubscription =
        onMutateDeletedWorkbookStream.stream.listen(
      (_) => setupWorkbooks(),
    );
  }

  final String? folderId;
  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateWorkbookStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;
  late final StreamSubscription<Workbook> onMutateDeletedWorkbookSubscription;

  Future<void> setupWorkbooks() async {
    state = const WorkbooksState.loading();
    final result = await workbookRepository.getWorkbooks(folderId);
    result.match(
      (l) => state = WorkbooksState.failure(exception: l),
      (r) => state = WorkbooksState.success(workbooks: r),
    );
  }

  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async {
    final result = await workbookRepository.addWorkbook(
      title: title,
      color: color,
      folderId: folderId,
    );

    return result.match(
      (l) => left(l),
      (r) {
        if (this.folderId == folderId) {
          state.maybeWhen(
            success: (workbooks) => state = WorkbooksState.success(
              workbooks: [...workbooks, r],
            ),
            orElse: () {},
          );
        }
        onMutateWorkbookStream.sink.add(r);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> updateWorkbook({
    required Workbook currentWorkbook,
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async {
    final updatedWorkbook = currentWorkbook.copyWith(
      title: title,
      color: color,
      folderId: folderId,
    );
    final result = await workbookRepository.updateWorkbook(updatedWorkbook);

    return result.match(
      (l) => left(l),
      (r) {
        if (this.folderId == folderId) {
          state.maybeWhen(
            success: (workbooks) => state = WorkbooksState.success(
              workbooks: workbooks.map(
                (e) {
                  if (e.workbookId == updatedWorkbook.workbookId) {
                    return updatedWorkbook;
                  } else {
                    return e;
                  }
                },
              ).toList(),
            ),
            orElse: () {},
          );
        }
        onMutateWorkbookStream.sink.add(updatedWorkbook);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> deleteWorkbook(Workbook workbook) async {
    final result = await workbookRepository.deleteWorkbook(workbook);
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (workbooks) {
            state = WorkbooksState.success(
              workbooks: workbooks
                  .where((e) => e.workbookId != workbook.workbookId)
                  .toList(),
            );
            onMutateWorkbookStream.sink.add(workbook);
          },
          orElse: () {},
        );

        return right(r);
      },
    );
  }

  @override
  void dispose() {
    onMutateDeletedWorkbookSubscription.cancel();
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateWorkbookStreamProvider = Provider(
  (ref) => StreamController<Workbook>.broadcast(),
);
