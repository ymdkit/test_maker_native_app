import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/folder.dart';

final folderProvider = Provider.family<Folder, String>(
  (ref, folderId) {
    final realm = ref.watch(realmProvider);

    return realm
        .all<RealmFolder>()
        .firstWhere((e) => e.folderId == folderId)
        .toFolder();
  },
);
