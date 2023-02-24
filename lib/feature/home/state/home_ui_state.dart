import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

part 'home_ui_state.freezed.dart';

@freezed
class HomeUiState with _$HomeUiState {
  const factory HomeUiState.loading() = HomeUiState_Loading;
  const factory HomeUiState.empty() = HomeUiState_Empty;
  const factory HomeUiState.success({
    required List<Folder> folders,
    required List<Workbook> workbooks,
  }) = HomeUiState_Success;
  const factory HomeUiState.failure({
    required AppException exception,
  }) = HomeUiState_Failure;
}

final homeUiStateProvider = Provider.autoDispose(
  (ref) {
    final foldersState = ref.watch(foldersProvider);
    final workbooksState = ref.watch(workbooksProvider(null));

    if (foldersState is AppAsyncState_Success &&
        workbooksState is AppAsyncState_Success) {
      final folders =
          (foldersState as AppAsyncState_Success<List<Folder>>).value;
      final workbooks =
          (workbooksState as AppAsyncState_Success<List<Workbook>>).value;

      if (folders.isEmpty && workbooks.isEmpty) {
        return const HomeUiState.empty();
      }
      return HomeUiState.success(
        folders: folders,
        workbooks: workbooks,
      );
    }

    if (foldersState is AppAsyncState_Failure ||
        workbooksState is AppAsyncState_Failure) {
      return const HomeUiState.failure(exception: AppException());
    }

    return const HomeUiState.loading();
  },
);
