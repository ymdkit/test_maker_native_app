import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';

part 'folder_state.g.dart';

@riverpod
Folder folder(FolderRef ref, String folderId) {
  final folders = ref.watch(foldersProvider);
  return folders.firstWhere((e) => e.folderId == folderId);
}
