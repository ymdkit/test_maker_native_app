import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/question.dart';

final checkIsCorrectUseCaseProvider =
    Provider((ref) => CheckIsCorrectUseCase());

class CheckIsCorrectUseCase {
  bool call({
    required Question question,
    required List<String> attemptAnswers,
  }) {
    if (question.isCheckAnswerOrder) {
      return listEquals(question.answers, attemptAnswers);
    } else {
      return setEquals(question.answers.toSet(), attemptAnswers.toSet());
    }
  }
}
