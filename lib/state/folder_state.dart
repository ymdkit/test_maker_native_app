import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/state/folders_state.dart';

part 'folder_state.g.dart';

@riverpod
Folder folder(FolderRef ref, String folderId) {
  final folders = ref.watch(foldersProvider);
  return folders.firstWhere((e) => e.folderId == folderId);
}
