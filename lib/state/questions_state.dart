import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/question.dart';

final questionsProvider = Provider.family<List<Question>, String>(
  (ref, workbookId) {
    final realm = ref.watch(realmProvider);

    return realm
        .all<RealmQuestion>()
        .where((e) => e.workbookId == workbookId)
        .map((e) => e.toQuestion())
        .toList();
  },
);
