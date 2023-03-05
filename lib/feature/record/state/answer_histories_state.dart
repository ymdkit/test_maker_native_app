import 'package:dartx/dartx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';

final answerHistoriesProvider =
    FutureProvider.autoDispose<List<AnswerHistoryGroup>>((ref) async {
  final repository = ref.watch(answerHistoryRepositoryProvider);
  final answerHistories = await repository.getAnswerHistories().run();

  return answerHistories.match(
    (l) => throw l,
    (r) => r
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
        .toList(),
  );
});

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
