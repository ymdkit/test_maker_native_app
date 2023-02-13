import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/repository/folder_repository.dart';

final foldersProvider =
    StateNotifierProvider.autoDispose<FoldersStateNotifier, List<Folder>>(
  (ref) => FoldersStateNotifier(
    folderRepository: ref.watch(folderRepositoryProvider),
  ),
);

class FoldersStateNotifier extends StateNotifier<List<Folder>> {
  FoldersStateNotifier({
    required this.folderRepository,
  }) : super(folderRepository.getFolders());

  final FolderRepository folderRepository;

  void addFolder({
    required String title,
    required ColorTheme color,
  }) {
    final newFolder = folderRepository.addFolder(
      title: title,
      color: color,
    );
    state = [...state, newFolder];
  }

  void updateFolder({
    required Folder currentFolder,
    required String title,
    required ColorTheme color,
  }) {
    final updatedFolder = currentFolder.copyWith(
      title: title,
      color: color.index,
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
  }

  void deleteFolder(Folder folder) {
    folderRepository.deleteFolder(folder);
    state = state.where((e) => e.folderId != folder.folderId).toList();
  }
}
