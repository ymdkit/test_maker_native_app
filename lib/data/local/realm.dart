import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm_question.dart';

final realmProvider = Provider(
  (ref) => Realm(
    Configuration.local(
      [
        RealmQuestion.schema,
      ],
    ),
  ),
);
