import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/feature/record/model/answer_history.dart';
import 'package:test_maker_native_app/feature/record/repository/local_answer_history_repository.dart';

final answerHistoryRepositoryProvider =
    Provider.autoDispose<AnswerHistoryRepository>((ref) {
  return LocalAnswerHistoryRepository(localDB: ref.watch(realmProvider));
});

abstract class AnswerHistoryRepository {
  AnswerHistory addAnswerHistory({
    required String workbookId,
    required String questionId,
    required bool isCorrect,
  });
  List<AnswerHistory> getAnswerHistories({
    String? questionId,
  });
}
