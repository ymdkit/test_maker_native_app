import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/utils/app_image.dart';

part 'answering_question.freezed.dart';

@freezed
class AnsweringQuestion with _$AnsweringQuestion {
  const factory AnsweringQuestion({
    required int displayIndex,
    required int totalCount,
    required String questionId,
    required QuestionType questionType,
    required String problem,
    required AppImage problemImage,
    required String? explanation,
    required AppImage explanationImage,
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

  AnsweringQuestion from(
    List<Question> questions,
    int index,
    int totalCount,
  ) {
    final question = questions[index];
    //TODO: テスト書く
    return AnsweringQuestion(
      displayIndex: index + 1,
      totalCount: totalCount,
      questionId: question.questionId,
      questionType: question.questionType,
      problem: preferences.isSwapProblemAndAnswer && question.reversible
          ? question.answers.join(' ')
          : question.problem,
      problemImage: question.problemImage,
      explanation: question.explanation,
      explanationImage: question.explanationImage,
      answers: preferences.isSwapProblemAndAnswer && question.reversible
          ? [question.problem]
          : question.answers,
      choices: question.isAutoGenerateWrongChoices
          ? [
              ...question.answers,
              ...questions
                  .where((element) => element.questionId != question.questionId)
                  .flatMap((e) => e.answers)
                  .shuffled()
                  .take(question.wrongChoices.length)
            ].shuffled()
          : [...question.answers, ...question.wrongChoices].shuffled(),
      isCheckAnswerOrder: question.isCheckAnswerOrder,
      rawQuestion: question,
    );
  }
}
