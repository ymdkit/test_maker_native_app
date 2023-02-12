import 'dart:io';

import 'package:collection/collection.dart';
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
            _migrateIOSFolders(migration);
            _migrateIOSWorkbooks(migration);
            _migrateIOSQuestions(migration);
          } else if (Platform.isAndroid) {
            _migrateAndroidFolders(migration);
            _migrateAndroidWorkbooks(migration);
          }
        }
      },
    ),
  ),
);

void _migrateIOSFolders(Migration migration) {
  final oldFolders = migration.oldRealm.all('Category');
  for (final oldFolder in oldFolders) {
    final newFolder = migration.findInNewRealm<RealmFolder>(oldFolder);

    if (newFolder != null) {
      newFolder
        ..folderId = oldFolder.dynamic.get<String>('id')
        ..title = oldFolder.dynamic.get<String>('category')
        ..order = oldFolder.dynamic.get<int>('order')
        ..color = oldFolder.dynamic.get<int>('themeColor');
    }
  }
}

void _migrateIOSWorkbooks(Migration migration) {
  final oldWorkbooks = migration.oldRealm.all('Test');
  for (final oldWorkbook in oldWorkbooks) {
    final newWorkbook = migration.findInNewRealm<RealmWorkbook>(oldWorkbook);

    if (newWorkbook != null) {
      final folders = migration.newRealm.all<RealmFolder>();
      final folderId = folders
          .firstWhereOrNull(
            (element) => element.title == oldWorkbook.dynamic.get('category'),
          )
          ?.folderId;

      newWorkbook
        ..workbookId = oldWorkbook.dynamic.get<String>('id')
        ..title = oldWorkbook.dynamic.get<String>('title')
        ..order = oldWorkbook.dynamic.get<int>('order')
        ..color = oldWorkbook.dynamic.get<int>('themeColor')
        ..folderId = folderId;
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

void _migrateAndroidFolders(Migration migration) {
  final oldFolders = migration.oldRealm.all('RealmCategory');

  migration.newRealm.addAll(
    oldFolders.map(
      (oldFolder) => RealmFolder(
        Uuid.v4().toString(),
        oldFolder.dynamic.get<String>('name'),
        oldFolder.dynamic.get<int>('order'),
        ColorTheme.from(oldFolder.dynamic.get<String>('themeColor')).index,
      ),
    ),
  );
}

void _migrateAndroidWorkbooks(Migration migration) {
  final folders = migration.newRealm.all<RealmFolder>();
  final oldWorkbooks = migration.oldRealm.all('RealmTest');

  migration.newRealm.addAll(
    oldWorkbooks.map(
      (oldWorkbook) {
        final folderId = folders
            .firstWhereOrNull(
              (element) =>
                  element.title == oldWorkbook.dynamic.get<String?>('category'),
            )
            ?.folderId;

        return _androidOldWorkbookToRealmWorkbook(
          oldWorkbook,
          folderId,
        );
      },
    ),
  );
}

RealmQuestion _androidOldQuestionToRealmQuestion(RealmObjectBase oldQuestion) =>
    RealmQuestion(
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
              (e! as RealmObjectBase).dynamic.get<String?>('select') ?? '')
          .toList(),
      wrongChoices: oldQuestion.dynamic
          .getList('selections')
          .map((e) =>
              (e! as RealmObjectBase).dynamic.get<String?>('select') ?? '')
          .toList(),
    );

RealmWorkbook _androidOldWorkbookToRealmWorkbook(
  RealmObjectBase oldWorkbook,
  String? folderId,
) {
  final childQuestions = oldWorkbook.dynamic.getList('questions').map(
        (e) => _androidOldQuestionToRealmQuestion(e! as RealmObjectBase),
      );

  return RealmWorkbook(
    Uuid.v4().toString(),
    oldWorkbook.dynamic.get<String?>('title') ?? '',
    oldWorkbook.dynamic.get<int>('order'),
    ColorTheme.from(oldWorkbook.dynamic.get<String>('themeColor')).index,
    folderId: folderId,
    questions: childQuestions,
  );
}
