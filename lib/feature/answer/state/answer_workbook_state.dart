import 'dart:async';

import 'package:dartx/dartx_io.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/model/question_condition.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';

part 'answer_workbook_state.freezed.dart';

@freezed
class AnswerWorkbookState with _$AnswerWorkbookState {
  const factory AnswerWorkbookState.empty() = Empty;
  const factory AnswerWorkbookState.answering({required Question question}) =
      Answering;
  const factory AnswerWorkbookState.confirming({required Question question}) =
      Confirming;
  const factory AnswerWorkbookState.selfScoring({required Question question}) =
      SelfScoring;
  const factory AnswerWorkbookState.reviewing({
    required Question question,
    required List<String> attemptAnswers,
  }) = Reviewing;
  const factory AnswerWorkbookState.idling() = Idling;
  const factory AnswerWorkbookState.finished(
      {required List<Question> questions}) = Finished;
  const factory AnswerWorkbookState.error({required String message}) = Error;
}

final answerWorkbookStateProvider = StateNotifierProvider.autoDispose
    .family<AnswerWorkbookStateNotifier, AnswerWorkbookState, String>(
  (ref, workbookId) {
    return AnswerWorkbookStateNotifier(
      workbookId: workbookId,
      preferences: ref.watch(preferencesStateProvider),
      questionRepository: ref.watch(questionRepositoryProvider),
      onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    );
  },
);

class AnswerWorkbookStateNotifier extends StateNotifier<AnswerWorkbookState> {
  AnswerWorkbookStateNotifier({
    required this.workbookId,
    required this.preferences,
    required this.questionRepository,
    required StreamController<Question> onMutateQuestionStream,
  }) : super(const AnswerWorkbookState.idling()) {
    onMutateQuestionSubscription =
        onMutateQuestionStream.stream.listen((question) {
      questions = questions
          .map((e) => e.questionId == question.questionId ? question : e)
          .toList();

      state.maybeWhen(
        selfScoring: (selfScoringQuestion) {
          if (selfScoringQuestion.questionId == question.questionId) {
            state = AnswerWorkbookState.selfScoring(question: question);
          }
        },
        reviewing: (reviewingQuestion, attemptAnswers) {
          if (reviewingQuestion.questionId == question.questionId) {
            state = AnswerWorkbookState.reviewing(
              question: question,
              attemptAnswers: attemptAnswers,
            );
          }
        },
        finished: (_) {
          state = AnswerWorkbookState.finished(questions: questions);
        },
        orElse: () {},
      );
    });
    _setup();
  }

  final String workbookId;
  final PreferencesState preferences;
  final QuestionRepository questionRepository;
  late final StreamSubscription<Question> onMutateQuestionSubscription;
  int index = 0;
  List<Question> questions = [];

  Future<void> _setup() async {
    index = 0;
    await _setupQuestions();
    if (questions.isEmpty) {
      state = const AnswerWorkbookState.empty();
      return;
    }
    if (preferences.isSelfScoring) {
      state = AnswerWorkbookState.confirming(question: questions[index]);
    } else {
      state = AnswerWorkbookState.answering(question: questions[index]);
    }
  }

  Future<void> _setupQuestions() async {
    //TODO: テスト書く
    final result = await questionRepository.getQuestions(workbookId);

    result.match(
      //TODO: 問題の読み込みに失敗した場合に、 UI へエラーを伝搬する
      (l) => state = AnswerWorkbookState.error(message: l.message),
      (r) {
        questions = r;

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
        questions = questions.take(preferences.numberOfQuestions).toList();
      },
    );
  }

  Future<void> onAnswered({
    required bool isCorrect,
    required List<String> attemptAnswers,
  }) async {
    if (preferences.isAlwaysShowExplanation) {
      state = AnswerWorkbookState.reviewing(
          question: questions[index], attemptAnswers: attemptAnswers);
      return;
    }

    if (isCorrect) {
      await forward();
    } else {
      state = AnswerWorkbookState.reviewing(
        question: questions[index],
        attemptAnswers: attemptAnswers,
      );
    }
  }

  Future<void> forward() async {
    //NOTE: AnswerQuestionForm を表示したままだと前問解答時の状態が残るため、
    //一旦 AnswerQuestionForm を破棄してから再表示する
    state = const AnswerWorkbookState.idling();
    await Future<void>.delayed(const Duration(milliseconds: 100));

    if (index < questions.length - 1) {
      index++;

      if (preferences.isSelfScoring) {
        state = AnswerWorkbookState.confirming(question: questions[index]);
      } else {
        state = AnswerWorkbookState.answering(question: questions[index]);
      }
    } else {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      state = AnswerWorkbookState.finished(questions: questions);
    }
  }

  void confirm() =>
      state = AnswerWorkbookState.confirming(question: questions[index]);

  void selfScore() =>
      state = AnswerWorkbookState.selfScoring(question: questions[index]);

  void reset() => _setup();

  void updateAnswerStatus(Question question, bool isCorrect) {
    final newQuestion = question.copyWith(
      answerStatus: isCorrect ? AnswerStatus.correct : AnswerStatus.wrong,
      lastAnsweredAt: DateTime.now(),
    );
    questionRepository.updateQuestion(newQuestion);
    questions = questions
        .map((e) => e.questionId == question.questionId ? newQuestion : e)
        .toList();
  }

  @override
  void dispose() {
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}
