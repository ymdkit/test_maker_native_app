import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/workbook.dart';

final workbooksProvider = Provider.family<List<Workbook>, String?>(
  (ref, folderId) {
    final realm = ref.watch(realmProvider);

    return realm
        .all<RealmWorkbook>()
        .where((e) => e.folderId == folderId)
        .map((e) => e.toWorkbook())
        .toList();
  },
);
