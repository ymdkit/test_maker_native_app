import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/enum/answer_status.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';

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
            _migrateAndroidWorkbooks(migration);
            _migrateAndroidFolders(migration);
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

void _migrateAndroidWorkbooks(Migration migration) {
  final oldWorkbooks = migration.oldRealm.all('RealmTest');

  migration.newRealm.addAll(
    oldWorkbooks.map(
      (oldWorkbook) {
        final childQuestions = oldWorkbook.dynamic.getList('questions').map(
          (e) {
            final oldQuestion = e! as RealmObjectBase;

            return RealmQuestion(
              Uuid.v4().toString(),
              oldQuestion.dynamic.get<int>('type'),
              oldQuestion.dynamic.get<String>('problem'),
              oldQuestion.dynamic.get<String>('answer'),
              oldQuestion.dynamic.get<bool>('auto'),
              oldQuestion.dynamic.get<bool>('isCheckOrder'),
              oldQuestion.dynamic.get<int>('order'),
              oldQuestion.dynamic.get<bool>('correct')
                  ? AnswerStatus.correct.value
                  : AnswerStatus.wrong.value,
              problemImageUrl: oldQuestion.dynamic.get<String>('imagePath'),
              explanation: oldQuestion.dynamic.get<String>('explanation'),
              explanationImageUrl:
                  oldQuestion.dynamic.get<String>('explanationImageUrl'),
              answers: oldQuestion.dynamic
                  .getList('answers')
                  .map((e) =>
                      (e! as RealmObjectBase).dynamic.get<String?>('select') ??
                      '')
                  .toList(),
              wrongChoices: oldQuestion.dynamic
                  .getList('selections')
                  .map((e) =>
                      (e! as RealmObjectBase).dynamic.get<String?>('select') ??
                      '')
                  .toList(),
            );
          },
        );

        return RealmWorkbook(
          Uuid.v4().toString(),
          oldWorkbook.dynamic.get<String?>('title') ?? '',
          oldWorkbook.dynamic.get<int>('order'),
          ColorTheme.from(oldWorkbook.dynamic.get<String>('themeColor')).index,
          questions: childQuestions,
        );
      },
    ),
  );
}

void _migrateAndroidFolders(Migration migration) {
  final oldFolders = migration.oldRealm.all('RealmCategory');

  migration.newRealm.addAll(
    oldFolders.map(
      (oldFolder) {
        final childWorkbooks = migration.oldRealm.all('RealmTest').where(
            (element) =>
                element.dynamic.get('category') ==
                oldFolder.dynamic.get('name'));
        return RealmFolder(
          Uuid.v4().toString(),
          oldFolder.dynamic.get<String>('name'),
          oldFolder.dynamic.get<int>('order'),
          ColorTheme.from(oldFolder.dynamic.get<String>('themeColor')).index,
          workbooks: childWorkbooks
              .where(
                (e) => migration.findInNewRealm<RealmWorkbook>(e) != null,
              )
              .map(
                (e) => migration.findInNewRealm<RealmWorkbook>(e)!,
              )
              .toList(),
        );
      },
    ),
  );
}
