import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';

final workbooksProvider = Provider((ref) {
  final realm = ref.watch(realmProvider);
  return realm.all<RealmWorkbook>().map((e) => e.toWorkbook()).toList();
});