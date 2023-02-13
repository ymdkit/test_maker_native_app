import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';

final folderProvider = Provider.family<Folder, String>(
  (ref, folderId) {
    final realm = ref.watch(realmProvider);
    final workbookRepository = ref.watch(workbookRepositoryProvider);

    final realmFolder =
        realm.all<RealmFolder>().firstWhere((e) => e.folderId == folderId);

    final workbookCount =
        workbookRepository.getWorkbooks(realmFolder.folderId).length;
    return realmFolder.toFolder(workbookCount: workbookCount);
  },
);
