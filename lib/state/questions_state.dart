import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';

final questionsProvider = Provider((ref) {
  final realm = ref.watch(realmProvider);
  return realm.all<RealmQuestion>().map((e) => e.toQuestion()).toList();
});
