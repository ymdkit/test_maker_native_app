import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

part 'select_workbook_ui_state.freezed.dart';

@freezed
class SelectWorkbookUiState with _$SelectWorkbookUiState {
  const factory SelectWorkbookUiState.loading() = SelectWorkbookUiState_Loading;
  const factory SelectWorkbookUiState.empty() = SelectWorkbookUiState_Empty;
  const factory SelectWorkbookUiState.success({
    required List<Folder> folders,
    required List<Workbook> workbooks,
  }) = SelectWorkbookUiState_Success;
  const factory SelectWorkbookUiState.failure({
    required AppException exception,
  }) = SelectWorkbookUiState_Failure;
}

final selectWorkbookUiStateProvider =
    Provider.family.autoDispose<SelectWorkbookUiState, WorkbooksStateKey>(
  (ref, key) {
    final foldersState = key.folderId == null
        ? ref.watch(
            foldersProvider(
              FoldersStateKey(location: key.location),
            ),
          )
        : const AppAsyncState_Success<List<Folder>>(value: []);

    final workbooksState = ref.watch(
      workbooksProvider(
        WorkbooksStateKey(location: key.location, folderId: key.folderId),
      ),
    );

    if (foldersState is AppAsyncState_Success &&
        workbooksState is AppAsyncState_Success) {
      final localFolders =
          (foldersState as AppAsyncState_Success<List<Folder>>).value;

      final localWorkbooks =
          (workbooksState as AppAsyncState_Success<List<Workbook>>).value;

      if (localFolders.isEmpty && localWorkbooks.isEmpty) {
        return const SelectWorkbookUiState.empty();
      }
      return SelectWorkbookUiState.success(
        folders: localFolders,
        workbooks: localWorkbooks,
      );
    }

    if (foldersState is AppAsyncState_Failure) {
      return SelectWorkbookUiState.failure(
          exception: (foldersState as AppAsyncState_Failure).exception);
    }

    if (workbooksState is AppAsyncState_Failure) {
      return SelectWorkbookUiState.failure(
          exception: (workbooksState as AppAsyncState_Failure).exception);
    }

    return const SelectWorkbookUiState.loading();
  },
);
