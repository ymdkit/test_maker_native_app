import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/model/enum/answer_status.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';
import 'package:test_maker_native_app/model/question.dart';

final questionRepositoryProvider = Provider<QuestionRepository>(
  (ref) => QuestionRepository(
    localDB: ref.watch(realmProvider),
  ),
);

class QuestionRepository {
  QuestionRepository({
    required this.localDB,
  });

  final Realm localDB;

  Question addQuestion({
    required String workbookId,
    required QuestionType questionType,
    required String problem,
    required String? problemImageUrl,
    required List<String> answers,
    required List<String> wrongChoices,
    required String? explanation,
    required String? explanationImageUrl,
    required bool isAutoGenerateWrongChoices,
    required bool isCheckAnswerOrder,
  }) {
    final newOrder =
        (localDB.all<RealmQuestion>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final question = Question(
      questionId: Uuid.v4().toString(),
      questionType: questionType,
      workbookId: workbookId,
      problem: problem,
      problemImageUrl: problemImageUrl,
      answers: answers,
      wrongChoices: wrongChoices,
      explanation: explanation,
      explanationImageUrl: explanationImageUrl,
      isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
      isCheckAnswerOrder: isCheckAnswerOrder,
      order: newOrder,
      answerStatus: AnswerStatus.unAnswered,
    );

    localDB.write(() {
      localDB.add<RealmQuestion>(
        RealmQuestionConverting.fromQuestion(question),
      );
    });

    return question;
  }

  List<Question> getQuestions(String workbookId) {
    return localDB
        .all<RealmQuestion>()
        .where((e) => e.workbookId == workbookId)
        .map((e) => e.toQuestion())
        .toList();
  }

  void updateQuestion(Question question) {
    localDB.write(() {
      localDB.add<RealmQuestion>(
        RealmQuestionConverting.fromQuestion(question),
      );
    });
  }

  void deleteQuestion(Question question) {
    localDB.write(
      () {
        localDB.delete<RealmQuestion>(
          RealmQuestionConverting.fromQuestion(question),
        );
      },
    );
  }
}
