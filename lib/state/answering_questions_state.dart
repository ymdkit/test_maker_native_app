import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/answer_status.dart';
import 'package:test_maker_native_app/model/enum/question_condition.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/repository/question_repository.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';

final answeringQuestionsProvider =
    Provider.family.autoDispose<List<Question>, String>(
  (ref, workbookId) {
    //TODO: テスト書く

    final questionRepository = ref.watch(questionRepositoryProvider);
    final preferences = ref.watch(preferencesStateProvider);

    var questions = questionRepository.getQuestions(workbookId);

    if (preferences.isRandom) {
      questions = questions.shuffled();
    }

    switch (preferences.questionCondition) {
      case QuestionCondition.all:
        break;
      case QuestionCondition.onlyWrong:
        questions = questions
            .where((e) => e.answerStatus == AnswerStatus.wrong)
            .toList();
        break;
      case QuestionCondition.onlyUnAnswered:
        questions = questions
            .where((e) => e.answerStatus == AnswerStatus.unAnswered)
            .toList();
        break;
      case QuestionCondition.wrongAndUnAnswered:
        questions = questions
            .where((e) =>
                e.answerStatus == AnswerStatus.wrong ||
                e.answerStatus == AnswerStatus.unAnswered)
            .toList();
        break;
      case QuestionCondition.weekPoints:
        //TODO: 正答率を算出する
        break;
    }

    return questions.take(preferences.numberOfQuestions).toList();
  },
);
