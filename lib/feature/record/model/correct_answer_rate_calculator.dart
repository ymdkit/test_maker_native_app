import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';

final calculateAnswerRateUseCaseProvider =
    Provider.autoDispose<CalculateAnswerRateUseCase>((ref) {
  return CalculateAnswerRateUseCase(
    answerHistoryRepository: ref.watch(answerHistoryRepositoryProvider),
  );
});

class CalculateAnswerRateUseCase {
  CalculateAnswerRateUseCase({
    required this.answerHistoryRepository,
  });

  final AnswerHistoryRepository answerHistoryRepository;
  double call({required String questionId}) {
    final histories = answerHistoryRepository.getAnswerHistories(
      questionId: questionId,
    );

    final correctCount = histories.where((element) => element.isCorrect).length;
    final totalCount = histories.length;
    return correctCount / max(totalCount, 1);
  }
}
