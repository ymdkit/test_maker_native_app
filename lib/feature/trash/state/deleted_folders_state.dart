import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/repository/folder_repository.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';

final deletedFoldersProvider = StateNotifierProvider.autoDispose<
    DeletedFoldersStateNotifier, List<Folder>>(
  (ref) => DeletedFoldersStateNotifier(
    folderRepository: ref.watch(folderRepositoryProvider),
    onMutateDeletedFolderStream: ref.watch(onMutateDeletedFolderStreamProvider),
    onMutateFolderStream: ref.watch(onMutateFolderStreamProvider),
  ),
);

class DeletedFoldersStateNotifier extends StateNotifier<List<Folder>> {
  DeletedFoldersStateNotifier({
    required this.folderRepository,
    required this.onMutateDeletedFolderStream,
    required StreamController<Folder> onMutateFolderStream,
  }) : super(folderRepository.getDeletedFolders()) {
    onMutateFolderSubscription = onMutateFolderStream.stream.listen(
      (folder) => state = folderRepository.getDeletedFolders(),
    );
  }

  final FolderRepository folderRepository;
  final StreamController<Folder> onMutateDeletedFolderStream;
  late final StreamSubscription<Folder> onMutateFolderSubscription;

  void restoreFolder(Folder folder) {
    folderRepository.restoreFolder(folder);
    state = state.where((e) => e.folderId != folder.folderId).toList();
    onMutateDeletedFolderStream.sink.add(folder);
  }

  void destroyFolders() {
    folderRepository.destroyFolders(state);
    state = [];
  }

  @override
  void dispose() {
    onMutateFolderSubscription.cancel();
    super.dispose();
  }
}

final onMutateDeletedFolderStreamProvider = Provider(
  (ref) => StreamController<Folder>.broadcast(),
);
