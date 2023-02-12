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
        RealmFolder.schema,
      ],
      schemaVersion: 23,
      migrationCallback: (migration, oldSchemaVersion) {
        if (oldSchemaVersion < 23) {
          if (Platform.isIOS) {
            _migrateIOSQuestions(migration);
            _migrateIOSWorkbooks(migration);
            _migrateIOSFolders(migration);
          } else if (Platform.isAndroid) {
            // TODO(ymdkit): Android migration
          }
        }
      },
    ),
  ),
);

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

void _migrateIOSFolders(Migration migration) {
  final oldFolders = migration.oldRealm.all('Category');
  for (final oldFolder in oldFolders) {
    final newFolder = migration.findInNewRealm<RealmFolder>(oldFolder);
    final childWorkbooks = migration.oldRealm.all('Test').where((element) =>
        element.dynamic.get('category') == oldFolder.dynamic.get('category'));
    if (newFolder != null) {
      newFolder
        ..folderId = oldFolder.dynamic.get<String>('id')
        ..title = oldFolder.dynamic.get<String>('category')
        ..order = oldFolder.dynamic.get<int>('order')
        ..color = oldFolder.dynamic.get<int>('themeColor');

      newFolder.workbooks.addAll(
        childWorkbooks
            .where(
              (e) => migration.findInNewRealm<RealmWorkbook>(e) != null,
            )
            .map(
              (e) => migration.findInNewRealm<RealmWorkbook>(e)!,
            ),
      );
    }
  }
}
