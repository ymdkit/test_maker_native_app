import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';

final checkIsCorrectUseCaseProvider = Provider.autoDispose(
  (ref) => CheckIsCorrectUseCase(
    isCaseInsensitive: ref.watch(
      preferencesStateProvider.select((value) => value.isCaseInsensitive),
    ),
    isSwapProblemAndAnswer: ref.watch(
      preferencesStateProvider.select((value) => value.isSwapProblemAndAnswer),
    ),
  ),
);

class CheckIsCorrectUseCase {
  const CheckIsCorrectUseCase({
    required this.isCaseInsensitive,
    required this.isSwapProblemAndAnswer,
  });
  // TODO: テスト書く

  final bool isCaseInsensitive;
  final bool isSwapProblemAndAnswer;

  bool call({
    required Question question,
    required List<String> attemptAnswers,
  }) {

    final originalAnswers =
        isSwapProblemAndAnswer ? [question.problem] : question.answers;

    if (question.isCheckAnswerOrder) {
      if (isCaseInsensitive) {
        return listEquals(
          originalAnswers.map((e) => e.toLowerCase()).toList(),
          attemptAnswers.map((e) => e.toLowerCase()).toList(),
        );
      } else {
        return listEquals(originalAnswers, attemptAnswers);
      }
    } else {
      if (isCaseInsensitive) {
        return setEquals(
          originalAnswers.map((e) => e.toLowerCase()).toSet(),
          attemptAnswers.map((e) => e.toLowerCase()).toSet(),
        );
      } else {
        return setEquals(originalAnswers.toSet(), attemptAnswers.toSet());
      }
    }
  }
}
