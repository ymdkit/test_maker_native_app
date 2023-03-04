import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/feature/record/model/answer_history.dart';
import 'package:test_maker_native_app/feature/record/repository/local_answer_history_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final answerHistoriesRepositoryProvider =
    Provider.autoDispose<AnswerHistoryRepository>((ref) {
  return LocalAnswerHistoryRepository(localDB: ref.watch(realmProvider));
});

abstract class AnswerHistoryRepository {
  TaskEither<AppException, AnswerHistory> addAnswerHistory(
      AnswerHistory answerHistory);
  TaskEither<AppException, List<AnswerHistory>> getAnswerHistories();
}
