import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_folders_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_questions_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

part 'trash_ui_state.freezed.dart';

@freezed
class TrashUiState with _$TrashUiState {
  const factory TrashUiState.loading() = TrashUiState_Loading;
  const factory TrashUiState.empty() = TrashUiState_Empty;
  const factory TrashUiState.success({
    required List<Folder> folders,
    required List<Workbook> workbooks,
    required List<Question> questions,
  }) = TrashUiState_Success;
  const factory TrashUiState.failure({
    required AppException exception,
  }) = TrashUiState_Failure;
}

final trashUiStateProvider = Provider.autoDispose(
  (ref) {
    final foldersState = ref.watch(deletedFoldersProvider);
    final workbooksState = ref.watch(deletedWorkbooksProvider);
    final questionsState = ref.watch(deletedQuestionsProvider);

    if (foldersState is AppAsyncState_Success &&
        workbooksState is AppAsyncState_Success &&
        questionsState is AppAsyncState_Success) {
      final folders =
          (foldersState as AppAsyncState_Success<List<Folder>>).value;
      final workbooks =
          (workbooksState as AppAsyncState_Success<List<Workbook>>).value;
      final questions =
          (questionsState as AppAsyncState_Success<List<Question>>).value;

      if (folders.isEmpty && workbooks.isEmpty && questions.isEmpty) {
        return const TrashUiState.empty();
      }
      return TrashUiState.success(
        folders: folders,
        workbooks: workbooks,
        questions: questions,
      );
    }

    if (foldersState is AppAsyncState_Failure ||
        workbooksState is AppAsyncState_Failure ||
        questionsState is AppAsyncState_Failure) {
      return const TrashUiState.failure(exception: AppException());
    }

    return const TrashUiState.loading();
  },
);
