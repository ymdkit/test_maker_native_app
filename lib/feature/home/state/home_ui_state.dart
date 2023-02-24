import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/data_source.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
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
    final remoteWorkbooksState = ref.watch(
      workbooksProvider(
        const WorkbooksStateKey(
            location: AppDataLocation.remoteOwned, folderId: null),
      ),
    );
    final localWorkbooksState = ref.watch(
      workbooksProvider(
        const WorkbooksStateKey(
            location: AppDataLocation.local, folderId: null),
      ),
    );

    if (foldersState is AppAsyncState_Success &&
        remoteWorkbooksState is AppAsyncState_Success &&
        localWorkbooksState is AppAsyncState_Success) {
      final folders =
          (foldersState as AppAsyncState_Success<List<Folder>>).value;
      final remoteWorkbooks =
          (remoteWorkbooksState as AppAsyncState_Success<List<Workbook>>).value;
      final localWorkbooks =
          (localWorkbooksState as AppAsyncState_Success<List<Workbook>>).value;

      if (folders.isEmpty &&
          remoteWorkbooks.isEmpty &&
          localWorkbooks.isEmpty) {
        return const HomeUiState.empty();
      }
      return HomeUiState.success(
        folders: folders,
        workbooks: remoteWorkbooks + localWorkbooks,
      );
    }

    if (foldersState is AppAsyncState_Failure ||
        remoteWorkbooksState is AppAsyncState_Failure ||
        localWorkbooksState is AppAsyncState_Failure) {
      return const HomeUiState.failure(exception: AppException());
    }

    return const HomeUiState.loading();
  },
);
