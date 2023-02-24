import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';

part 'folder_state.g.dart';

@riverpod
Folder folder(
  FolderRef ref, {
  required FoldersStateKey key,
  required String folderId,
}) {
  final foldersState = ref.watch(foldersProvider(key));
  return foldersState.maybeWhen(
    orElse: () => Folder.empty(),
    success: (folders) =>
        folders.firstWhereOrNull((e) => e.folderId == folderId) ??
        Folder.empty(),
  );
}
