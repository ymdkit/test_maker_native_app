import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/feature/answer/state/answering_questions_state.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';

part 'answer_workbook_state.freezed.dart';

@freezed
class AnswerWorkbookState with _$AnswerWorkbookState {
  const factory AnswerWorkbookState.answering({required Question question}) =
      Answering;
  const factory AnswerWorkbookState.confirming({required Question question}) =
      Confirming;
  const factory AnswerWorkbookState.selfScoring({required Question question}) =
      SelfScoring;
  const factory AnswerWorkbookState.reviewing({required Question question}) =
      Reviewing;
  const factory AnswerWorkbookState.idling() = Idling;
  const factory AnswerWorkbookState.finished() = Finished;
}

final answerWorkbookStateProvider = StateNotifierProvider.autoDispose
    .family<AnswerWorkbookStateNotifier, AnswerWorkbookState, String>(
  (ref, workbookId) {
    final questions = ref.watch(answeringQuestionsProvider(workbookId));
    final isSelfScoring = ref.watch(
      preferencesStateProvider.select((value) => value.isSelfScoring),
    );
    final isAlwaysShowExplanation = ref.watch(
      preferencesStateProvider.select((value) => value.isAlwaysShowExplanation),
    );
    return AnswerWorkbookStateNotifier(
      questions: questions,
      isSelfScoring: isSelfScoring,
      isAlwaysShowExplanation: isAlwaysShowExplanation,
    );
  },
);

class AnswerWorkbookStateNotifier extends StateNotifier<AnswerWorkbookState> {
  AnswerWorkbookStateNotifier(
      {required this.questions,
      required this.isSelfScoring,
      required this.isAlwaysShowExplanation})
      : super(
          isSelfScoring
              ? AnswerWorkbookState.confirming(question: questions[0])
              : AnswerWorkbookState.answering(question: questions[0]),
        );

  final List<Question> questions;
  final bool isSelfScoring;
  final bool isAlwaysShowExplanation;
  int index = 0;

  Future<void> onAnswered(bool isCorrect) async {
    if (isAlwaysShowExplanation) {
      state = AnswerWorkbookState.reviewing(question: questions[index]);
      return;
    }

    if (isCorrect) {
      await forward();
    } else {
      state = AnswerWorkbookState.reviewing(question: questions[index]);
    }
  }

  Future<void> forward() async {
    if (index < questions.length - 1) {
      //NOTE: AnswerQuestionForm を表示したままだと前問解答時の状態が残るため、
      //一旦 AnswerQuestionForm を破棄してから再表示する
      state = const AnswerWorkbookState.idling();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      index++;

      if (isSelfScoring) {
        state = AnswerWorkbookState.confirming(question: questions[index]);
      } else {
        state = AnswerWorkbookState.answering(question: questions[index]);
      }
    } else {
      state = const AnswerWorkbookState.finished();
    }
  }

  void confirm() =>
      state = AnswerWorkbookState.confirming(question: questions[index]);

  void selfScore() =>
      state = AnswerWorkbookState.selfScoring(question: questions[index]);
}
