import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';

final checkIsCorrectUseCaseProvider = Provider.autoDispose(
  (ref) => CheckIsCorrectUseCase(
    isCaseInsensitive: ref.watch(
      preferencesStateProvider.select((value) => value.isCaseInsensitive),
    ),
  ),
);

class CheckIsCorrectUseCase {
  const CheckIsCorrectUseCase({
    required this.isCaseInsensitive,
  });

  final bool isCaseInsensitive;

  bool call({
    required AnsweringQuestion question,
    required List<String> attemptAnswers,
  }) {
    if (question.isCheckAnswerOrder) {
      if (isCaseInsensitive) {
        return listEquals(
          question.answers.map((e) => e.toLowerCase()).toList(),
          attemptAnswers.map((e) => e.toLowerCase()).toList(),
        );
      } else {
        return listEquals(question.answers, attemptAnswers);
      }
    } else {
      if (isCaseInsensitive) {
        return setEquals(
          question.answers.map((e) => e.toLowerCase()).toSet(),
          attemptAnswers.map((e) => e.toLowerCase()).toSet(),
        );
      } else {
        return setEquals(question.answers.toSet(), attemptAnswers.toSet());
      }
    }
  }
}
