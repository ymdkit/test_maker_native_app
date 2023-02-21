import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/ui/utils/shared_preference.dart';

final checkIsCorrectUseCaseProvider = Provider.autoDispose(
  (ref) => CheckIsCorrectUseCase(
    isCaseInsensitive: ref.watch(
      sharedPreferencesProvider.select((value) =>
          value.getBool(PreferenceKey.isCaseInsensitive.name) ?? false),
    ),
  ),
);

class CheckIsCorrectUseCase {
  const CheckIsCorrectUseCase({
    required this.isCaseInsensitive,
  });
  // TODO: テスト書く

  final bool isCaseInsensitive;

  bool call({
    required Question question,
    required List<String> attemptAnswers,
  }) {
    final originalAnswers = question.answers;

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
