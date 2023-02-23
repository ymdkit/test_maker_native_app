import 'dart:io';

import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';

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
        ..color = oldFolder.dynamic.get<int>('themeColor')
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();
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
        ..folderId = folderId
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

      final oldQuestions = oldWorkbook.dynamic
          .getList('questions')
          .map(
            (e) => e! as RealmObject,
          )
          .toList();
      _migrateIOSQuestions(
        migration,
        newWorkbook.workbookId,
        oldQuestions,
      );
    }
  }
}

void _migrateIOSQuestions(
    Migration migration, String workbookId, List<RealmObject> oldQuestions) {
  for (final oldQuestion in oldQuestions) {
    final newQuestion = migration.findInNewRealm<RealmQuestion>(oldQuestion);
    if (newQuestion != null) {
      newQuestion
        ..questionId = oldQuestion.dynamic.get<String>('id')
        ..workbookId = workbookId
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
            oldQuestion.dynamic.get<String>('explanationImageUrl')
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now();

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
        AppThemeColor.from(oldFolder.dynamic.get<String>('themeColor')).index,
        DateTime.now(),
        DateTime.now(),
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

        final workbookId = Uuid.v4().toString();
        final childQuestions = oldWorkbook.dynamic.getList('questions').map(
              (e) => _androidOldQuestionToRealmQuestion(
                  e! as RealmObjectBase, workbookId),
            );
        migration.newRealm.addAll(childQuestions);

        return RealmWorkbook(
          workbookId,
          oldWorkbook.dynamic.get<String?>('title') ?? '',
          oldWorkbook.dynamic.get<int>('order'),
          AppThemeColor.from(oldWorkbook.dynamic.get<String>('themeColor'))
              .index,
          DateTime.now(),
          DateTime.now(),
          folderId: folderId,
        );
      },
    ),
  );
}

RealmQuestion _androidOldQuestionToRealmQuestion(
  RealmObjectBase oldQuestion,
  String workbookId,
) =>
    RealmQuestion(
      Uuid.v4().toString(),
      workbookId,
      oldQuestion.dynamic.get<int>('type'),
      oldQuestion.dynamic.get<String>('problem'),
      oldQuestion.dynamic.get<String>('answer'),
      oldQuestion.dynamic.get<bool>('auto'),
      oldQuestion.dynamic.get<bool>('isCheckOrder'),
      oldQuestion.dynamic.get<int>('order'),
      oldQuestion.dynamic.get<bool>('correct')
          ? AnswerStatus.correct.value
          : AnswerStatus.wrong.value,
      DateTime.now(),
      DateTime.now(),
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
