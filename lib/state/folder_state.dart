import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/state/folders_state.dart';

final folderProvider = Provider.autoDispose.family<Folder, String>(
  (ref, folderId) {
    final folders = ref.watch(foldersProvider);
    return folders.firstWhere((e) => e.folderId == folderId);
  },
);
