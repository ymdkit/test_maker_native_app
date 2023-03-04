import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/record/model/answer_history.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';

final answerHistoriesProvider =
    FutureProvider.autoDispose<List<AnswerHistory>>((ref) async {
  final repository = ref.watch(answerHistoriesRepositoryProvider);
  final answerHistories = await repository.getAnswerHistories().run();

  return answerHistories.match(
    (l) => throw l,
    (r) => r,
  );
});
