import 'package:dartx/dartx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';

final answerHistoriesProvider = Provider.autoDispose<List<AnswerHistoryGroup>>(
  (ref) {
    final repository = ref.watch(answerHistoryRepositoryProvider);
    final answerHistories = repository.getAnswerHistories();

    return answerHistories
        .groupBy((element) => element.createdAt.date)
        .entries
        .map(
          (entry) => AnswerHistoryGroup(
            date: entry.key,
            correctCount: entry.value.count((element) => element.isCorrect),
            incorrectCount: entry.value.count((element) => !element.isCorrect),
            totalCount: entry.value.length,
          ),
        )
        .toList();
  },
);

class AnswerHistoryGroup {
  final DateTime date;
  final int correctCount;
  final int incorrectCount;
  final int totalCount;

  AnswerHistoryGroup({
    required this.date,
    required this.correctCount,
    required this.incorrectCount,
    required this.totalCount,
  });
}
