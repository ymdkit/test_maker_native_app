import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/workbook.dart';

final workbookProvider = Provider.family<Workbook, String>(
  (ref, workbookId) {
    final realm = ref.watch(realmProvider);

    return realm
        .all<RealmWorkbook>()
        .firstWhere((e) => e.workbookId == workbookId)
        .toWorkbook();
  },
);
