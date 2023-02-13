import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/folder_repository.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';

final foldersProvider =
    StateNotifierProvider.autoDispose<FoldersStateNotifier, List<Folder>>(
  (ref) => FoldersStateNotifier(
    folderRepository: ref.watch(folderRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
  ),
);

class FoldersStateNotifier extends StateNotifier<List<Folder>> {
  FoldersStateNotifier({
    required this.folderRepository,
    required StreamController<Workbook> onMutateWorkbookStream,
  }) : super(folderRepository.getFolders()) {
    onMutateWorkbookSubscription = onMutateWorkbookStream.stream.listen(
      (workbook) => state = folderRepository.getFolders(),
    );
  }

  final FolderRepository folderRepository;
  late final StreamSubscription<Workbook> onMutateWorkbookSubscription;

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
  }

  void deleteFolder(Folder folder) {
    folderRepository.deleteFolder(folder);
    state = state.where((e) => e.folderId != folder.folderId).toList();
  }

  @override
  void dispose() {
    onMutateWorkbookSubscription.cancel();
    super.dispose();
  }
}
