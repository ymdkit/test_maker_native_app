import 'dart:async';

import 'package:dartx/dartx_io.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/feature/answer/model/question_condition.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/record/model/correct_answer_rate_calculator.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/setting/utils/shared_preference.dart';

part 'answer_workbook_state.freezed.dart';

@freezed
class AnswerWorkbookState with _$AnswerWorkbookState {
  const factory AnswerWorkbookState.empty() = Empty;
  const factory AnswerWorkbookState.answering({
    required AnsweringQuestion question,
  }) = Answering;
  const factory AnswerWorkbookState.confirming({
    required AnsweringQuestion question,
  }) = Confirming;
  const factory AnswerWorkbookState.selfScoring({
    required AnsweringQuestion question,
  }) = SelfScoring;
  const factory AnswerWorkbookState.reviewing({
    required AnsweringQuestion question,
    required List<String> attemptAnswers,
  }) = Reviewing;
  const factory AnswerWorkbookState.idling() = Idling;
  const factory AnswerWorkbookState.finished(
      {required List<Question> questions}) = Finished;
  const factory AnswerWorkbookState.error({required String message}) = Error;
}

final answerWorkbookStateProvider = StateNotifierProvider.autoDispose.family<
    AnswerWorkbookStateNotifier, AnswerWorkbookState, QuestionsStateKey>(
  (ref, key) {
    return AnswerWorkbookStateNotifier(
      workbookId: key.workbookId,
      preferences: ref.watch(preferencesStateProvider),
      questionRepository: ref.watch(questionRepositoryProvider(key.location)),
      answerHistoryRepository: ref.watch(answerHistoryRepositoryProvider),
      ref: ref,
      answeringQuestionFactory: ref.watch(answeringQuestionFactoryProvider),
      onMutateQuestionStream:
          ref.watch(onMutateQuestionStreamProvider(key.location)),
    );
  },
);

class AnswerWorkbookStateNotifier extends StateNotifier<AnswerWorkbookState> {
  AnswerWorkbookStateNotifier({
    required this.workbookId,
    required this.preferences,
    required this.questionRepository,
    required this.answerHistoryRepository,
    required this.ref,
    required this.answeringQuestionFactory,
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
            state = AnswerWorkbookState.selfScoring(
              question: answeringQuestionFactory.from(
                  questions, index, questions.length),
            );
          }
        },
        reviewing: (reviewingQuestion, attemptAnswers) {
          if (reviewingQuestion.questionId == question.questionId) {
            state = AnswerWorkbookState.reviewing(
              question: answeringQuestionFactory.from(
                  questions, index, questions.length),
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
  final AnswerHistoryRepository answerHistoryRepository;
  final AnsweringQuestionFactory answeringQuestionFactory;
  late final StreamSubscription<Question> onMutateQuestionSubscription;
  final Ref ref;
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
      state = AnswerWorkbookState.confirming(
        question:
            answeringQuestionFactory.from(questions, index, questions.length),
      );
    } else {
      state = AnswerWorkbookState.answering(
        question:
            answeringQuestionFactory.from(questions, index, questions.length),
      );
    }
  }

  Future<void> _setupQuestions() async {
    //TODO: テスト書く
    final result = await questionRepository.getQuestions(workbookId).run();

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
            final calculator = ref.read(calculateAnswerRateUseCaseProvider);
            questions = questions
                .where((e) => calculator.call(questionId: e.questionId) < 0.5)
                .toList();
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
          question:
              answeringQuestionFactory.from(questions, index, questions.length),
          attemptAnswers: attemptAnswers);
      return;
    }

    if (isCorrect) {
      await Future.delayed(const Duration(milliseconds: 500), () {});
      await forward();
    } else {
      state = AnswerWorkbookState.reviewing(
        question:
            answeringQuestionFactory.from(questions, index, questions.length),
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
        state = AnswerWorkbookState.confirming(
          question:
              answeringQuestionFactory.from(questions, index, questions.length),
        );
      } else {
        state = AnswerWorkbookState.answering(
          question:
              answeringQuestionFactory.from(questions, index, questions.length),
        );
      }
    } else {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await finish();
    }
  }

  void confirm() => state = AnswerWorkbookState.confirming(
        question:
            answeringQuestionFactory.from(questions, index, questions.length),
      );

  void selfScore() => state = AnswerWorkbookState.selfScoring(
        question:
            answeringQuestionFactory.from(questions, index, questions.length),
      );

  Future<void> finish() async {
    final currentAnswerCount = ref
            .read(sharedPreferencesProvider)
            .getInt(PreferenceKey.answerWorkbookCount.name) ??
        0;
    await ref
        .read(sharedPreferencesProvider)
        .setInt(PreferenceKey.answerWorkbookCount.name, currentAnswerCount + 1);
    state = AnswerWorkbookState.finished(
        questions: questions.take(index + 1).toList());
  }

  void reset() => _setup();

  Future<void> updateAnswerStatus(Question question, bool isCorrect) async {
    final newQuestion = question.copyWith(
      answerStatus: isCorrect ? AnswerStatus.correct : AnswerStatus.wrong,
      lastAnsweredAt: DateTime.now(),
    );
    await questionRepository.updateQuestion(newQuestion);

    answerHistoryRepository.addAnswerHistory(
      workbookId: newQuestion.workbookId,
      questionId: newQuestion.questionId,
      isCorrect: isCorrect,
    );

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
