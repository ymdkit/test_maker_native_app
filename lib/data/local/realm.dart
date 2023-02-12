import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm_question.dart';

final realmProvider = Provider(
  (ref) => Realm(
    Configuration.local(
      [
        RealmQuestion.schema,
      ],
      schemaVersion: 34,
      migrationCallback: (migration, oldSchemaVersion) {
        if (oldSchemaVersion < 34) {
          if (Platform.isIOS) {
            final oldQuestions = migration.oldRealm.all('Question');
            for (final oldQuestion in oldQuestions) {
              final newQuestion =
                  migration.findInNewRealm<RealmQuestion>(oldQuestion);
              if (newQuestion != null) {
                newQuestion
                  ..questionId = oldQuestion.dynamic.get<String>('id')
                  ..questionType = oldQuestion.dynamic.get<int>('type')
                  ..problem = oldQuestion.dynamic.get<String>('problem')
                  ..answer = oldQuestion.dynamic.get<String>('answer')
                  ..isAutoGenerateWrongChoices =
                      oldQuestion.dynamic.get<bool>('auto')
                  ..isCheckAnswerOrder =
                      oldQuestion.dynamic.get<bool>('isCheckOrder')
                  ..order = oldQuestion.dynamic.get<int>('order')
                  ..answerStatus =
                      oldQuestion.dynamic.get<String>('answerStatus')
                  ..problemImageUrl =
                      oldQuestion.dynamic.get<String>('imagePath')
                  ..explanation = oldQuestion.dynamic.get<String>('explanation')
                  ..explanationImageUrl =
                      oldQuestion.dynamic.get<String>('explanationImageUrl');

                newQuestion.answers.addAll(
                  oldQuestion.dynamic
                      .getList('answers')
                      .map(
                        (e) =>
                            (e! as RealmObjectBase).dynamic.get<String>('str'),
                      )
                      .toList(),
                );

                newQuestion.wrongChoices.addAll(
                  oldQuestion.dynamic
                      .getList('others')
                      .map(
                        (e) =>
                            (e! as RealmObjectBase).dynamic.get<String>('str'),
                      )
                      .toList(),
                );
              }
            }
          } else if (Platform.isAndroid) {
            // TODO(ymdkit): Android migration
          }
        }
      },
    ),
  ),
);
