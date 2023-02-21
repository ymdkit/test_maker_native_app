import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/model/question_condition.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';

final answeringQuestionsProvider = StateNotifierProvider.family
    .autoDispose<AnsweringQuestionsStateNotifier, List<Question>, String>(
  (ref, workbookId) {
    final questionRepository = ref.watch(questionRepositoryProvider);
    final preferences = ref.watch(preferencesStateProvider);

    return AnsweringQuestionsStateNotifier(
      workbookId: workbookId,
      questionRepository: questionRepository,
      preferences: preferences,
    );
  },
);

class AnsweringQuestionsStateNotifier extends StateNotifier<List<Question>> {
  AnsweringQuestionsStateNotifier({
    required this.workbookId,
    required this.questionRepository,
    required this.preferences,
  }) : super(const <Question>[]) {
    _init();
  }

  final String workbookId;
  final QuestionRepository questionRepository;
  final PreferencesState preferences;

  void _init() {
    //TODO: テスト書く
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
    state = questions.take(preferences.numberOfQuestions).toList();
  }

  void updateAnswerStatus(Question question, bool isCorrect) {
    questionRepository.updateQuestion(
      question.copyWith(
        answerStatus: isCorrect ? AnswerStatus.correct : AnswerStatus.wrong,
      ),
    );
  }
}
