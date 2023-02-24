import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/repository/folder_repository.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_folders_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

typedef FoldersState = AppAsyncState<List<Folder>>;

final foldersProvider = StateNotifierProvider.autoDispose
    .family<FoldersStateNotifier, FoldersState, FoldersStateKey>((ref, key) {
  final _ = ref.watch(accountStateProvider);
  return FoldersStateNotifier(
    folderRepository: ref.watch(folderRepositoryProvider(key.location)),
    onMutateFolderStream: ref.watch(onMutateFolderStreamProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateDeletedFolderStream: ref.watch(onMutateDeletedFolderStreamProvider),
  );
});

class FoldersStateNotifier extends StateNotifier<FoldersState> {
  FoldersStateNotifier({
    required this.folderRepository,
    required this.onMutateFolderStream,
    required StreamController<Workbook> onMutateWorkbookStream,
    required StreamController<Folder> onMutateDeletedFolderStream,
  }) : super(const FoldersState.loading()) {
    setupFolders();
    onMutateWorkbookSubscription = onMutateWorkbookStream.stream.listen(
      (workbook) => setupFolders(),
    );
    onMutateDeletedFolderSubscription =
        onMutateDeletedFolderStream.stream.listen(
      (folder) => setupFolders(),
    );
  }

  final FolderRepository folderRepository;
  final StreamController<Folder> onMutateFolderStream;
  late final StreamSubscription<Workbook> onMutateWorkbookSubscription;
  late final StreamSubscription<Folder> onMutateDeletedFolderSubscription;

  Future<void> setupFolders() async {
    state = const FoldersState.loading();
    final result = await folderRepository.getFolders();
    result.match(
      (l) => state = FoldersState.failure(exception: l),
      (r) => state = FoldersState.success(value: r),
    );
  }

  Future<Either<AppException, Folder>> addFolder({
    required String title,
    required AppThemeColor color,
  }) async {
    final result = await folderRepository.addFolder(
      title: title,
      color: color,
    );
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (folders) => state = FoldersState.success(
            value: [...folders, r],
          ),
          orElse: () {},
        );
        onMutateFolderStream.sink.add(r);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> updateFolder({
    required Folder currentFolder,
    required String title,
    required AppThemeColor color,
  }) async {
    final updatedFolder = currentFolder.copyWith(
      title: title,
      color: color,
    );
    final result = await folderRepository.updateFolder(updatedFolder);

    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (folders) => state = FoldersState.success(
            value: folders.map(
              (e) {
                if (e.folderId == updatedFolder.folderId) {
                  return updatedFolder;
                } else {
                  return e;
                }
              },
            ).toList(),
          ),
          orElse: () {},
        );
        onMutateFolderStream.sink.add(updatedFolder);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> deleteFolder(Folder folder) async {
    final result = await folderRepository.deleteFolder(folder);
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (folders) {
            state = FoldersState.success(
              value:
                  folders.where((e) => e.folderId != folder.folderId).toList(),
            );
            onMutateFolderStream.sink.add(folder);
          },
          orElse: () {},
        );

        return right(r);
      },
    );
  }

  @override
  void dispose() {
    onMutateWorkbookSubscription.cancel();
    onMutateDeletedFolderSubscription.cancel();
    super.dispose();
  }
}

final onMutateFolderStreamProvider = Provider(
  (ref) => StreamController<Folder>.broadcast(),
);
