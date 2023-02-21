import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/repository/folder_repository.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';

final foldersProvider =
    StateNotifierProvider.autoDispose<FoldersStateNotifier, List<Folder>>(
  (ref) => FoldersStateNotifier(
    folderRepository: ref.watch(folderRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateFolderStream: ref.watch(onMutateFolderStreamProvider),
    onMutateDeletedFolderStream: ref.watch(onMutateFolderStreamProvider),
  ),
);

class FoldersStateNotifier extends StateNotifier<List<Folder>> {
  FoldersStateNotifier({
    required this.folderRepository,
    required this.onMutateFolderStream,
    required StreamController<Workbook> onMutateWorkbookStream,
    required StreamController<Folder> onMutateDeletedFolderStream,
  }) : super(folderRepository.getFolders()) {
    onMutateWorkbookSubscription = onMutateWorkbookStream.stream.listen(
      (workbook) => state = folderRepository.getFolders(),
    );
    onMutateDeletedFolderSubscription =
        onMutateDeletedFolderStream.stream.listen(
      (folder) => state = folderRepository.getFolders(),
    );
  }

  final FolderRepository folderRepository;
  final StreamController<Folder> onMutateFolderStream;
  late final StreamSubscription<Workbook> onMutateWorkbookSubscription;
  late final StreamSubscription<Folder> onMutateDeletedFolderSubscription;

  void addFolder({
    required String title,
    required AppThemeColor color,
  }) {
    final newFolder = folderRepository.addFolder(
      title: title,
      color: color,
    );
    state = [...state, newFolder];
    onMutateFolderStream.sink.add(newFolder);
  }

  void updateFolder({
    required Folder currentFolder,
    required String title,
    required AppThemeColor color,
  }) {
    final updatedFolder = currentFolder.copyWith(
      title: title,
      color: color,
    );
    folderRepository.updateFolder(updatedFolder);

    state = state.map(
      (e) {
        if (e.folderId == updatedFolder.folderId) {
          return updatedFolder;
        } else {
          return e;
        }
      },
    ).toList();
    onMutateFolderStream.sink.add(updatedFolder);
  }

  void deleteFolder(Folder folder) {
    folderRepository.deleteFolder(folder);
    state = state.where((e) => e.folderId != folder.folderId).toList();
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
