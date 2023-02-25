import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';

part 'answering_question.freezed.dart';

@freezed
class AnsweringQuestion with _$AnsweringQuestion {
  const factory AnsweringQuestion({
    required String questionId,
    required QuestionType questionType,
    required String problem,
    required String? problemImageUrl,
    required String? explanation,
    required String? explanationImageUrl,
    required List<String> answers,
    required List<String> choices,
    required bool isCheckAnswerOrder,
    required Question rawQuestion,
  }) = _AnsweringQuestion;
}

final answeringQuestionFactoryProvider = Provider.autoDispose(
  (ref) => AnsweringQuestionFactory(
    preferences: ref.watch(preferencesStateProvider),
  ),
);

class AnsweringQuestionFactory {
  const AnsweringQuestionFactory({
    required this.preferences,
  });
  final PreferencesState preferences;

  AnsweringQuestion from(Question question, List<Question> questions) {
    //TODO: テスト書く
    return AnsweringQuestion(
      questionId: question.questionId,
      questionType: question.questionType,
      problem: preferences.isSwapProblemAndAnswer && question.reversible
          ? question.answers.join(' ')
          : question.problem,
      problemImageUrl: question.problemImageUrl,
      explanation: question.explanation,
      explanationImageUrl: question.explanationImageUrl,
      answers: preferences.isSwapProblemAndAnswer && question.reversible
          ? [question.problem]
          : question.answers,
      choices: question.isAutoGenerateWrongChoices
          ? [
                ...question.answers,
                ...questions
                    .where(
                        (element) => element.questionId != question.questionId)
                    .flatMap((e) => e.answers)
                    .shuffled()
                    .take(question.wrongChoices.length)
              ].shuffled() +
              ['わからない']
          : [...question.answers, ...question.wrongChoices].shuffled() +
              ['わからない'],
      isCheckAnswerOrder: question.isCheckAnswerOrder,
      rawQuestion: question,
    );
  }
}
