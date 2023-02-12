import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';

final realmProvider = Provider(
  (ref) => Realm(
    Configuration.local(
      [
        RealmQuestion.schema,
        RealmWorkbook.schema,
      ],
      schemaVersion: 35,
      migrationCallback: (migration, oldSchemaVersion) {
        if (oldSchemaVersion < 35) {
          if (Platform.isIOS) {
            _migrateIOSWorkbooks(migration);
            _migrateIOSQuestions(migration);
          } else if (Platform.isAndroid) {
            // TODO(ymdkit): Android migration
          }
        }
      },
    ),
  ),
);

void _migrateIOSWorkbooks(Migration migration) {
  final oldWorkbooks = migration.oldRealm.all('Test');
  for (final oldWorkbook in oldWorkbooks) {
    final newWorkbook = migration.findInNewRealm<RealmWorkbook>(oldWorkbook);
    if (newWorkbook != null) {
      newWorkbook
        ..workbookId = oldWorkbook.dynamic.get<String>('id')
        ..title = oldWorkbook.dynamic.get<String>('title')
        ..order = oldWorkbook.dynamic.get<int>('order')
        ..color = oldWorkbook.dynamic.get<int>('themeColor');
    }
  }
}

void _migrateIOSQuestions(Migration migration) {
  final oldQuestions = migration.oldRealm.all('Question');
  for (final oldQuestion in oldQuestions) {
    final newQuestion = migration.findInNewRealm<RealmQuestion>(oldQuestion);
    if (newQuestion != null) {
      newQuestion
        ..questionId = oldQuestion.dynamic.get<String>('id')
        ..questionType = oldQuestion.dynamic.get<int>('type')
        ..problem = oldQuestion.dynamic.get<String>('problem')
        ..answer = oldQuestion.dynamic.get<String>('answer')
        ..isAutoGenerateWrongChoices = oldQuestion.dynamic.get<bool>('auto')
        ..isCheckAnswerOrder = oldQuestion.dynamic.get<bool>('isCheckOrder')
        ..order = oldQuestion.dynamic.get<int>('order')
        ..answerStatus = oldQuestion.dynamic.get<String>('answerStatus')
        ..problemImageUrl = oldQuestion.dynamic.get<String>('imagePath')
        ..explanation = oldQuestion.dynamic.get<String>('explanation')
        ..explanationImageUrl =
            oldQuestion.dynamic.get<String>('explanationImageUrl');

      newQuestion.answers.addAll(
        oldQuestion.dynamic
            .getList('answers')
            .map(
              (e) => (e! as RealmObjectBase).dynamic.get<String>('str'),
            )
            .toList(),
      );

      newQuestion.wrongChoices.addAll(
        oldQuestion.dynamic
            .getList('others')
            .map(
              (e) => (e! as RealmObjectBase).dynamic.get<String>('str'),
            )
            .toList(),
      );
    }
  }
}
