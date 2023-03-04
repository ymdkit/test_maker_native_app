import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/record/model/answer_history.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class LocalAnswerHistoryRepository implements AnswerHistoryRepository {
  LocalAnswerHistoryRepository({
    required this.localDB,
  });

  final Realm localDB;

  @override
  TaskEither<AppException, AnswerHistory> addAnswerHistory(
          AnswerHistory answerHistory) =>
      TaskEither.tryCatch(
        () async {
          localDB.write(() {
            localDB.add<RealmAnswerHistory>(
                RealmAnswerHistoryConverting.fromAnswerHistory(answerHistory));
          });
          return answerHistory;
        },
        (e, _) => AppException.fromRawException(e: e),
      );

  @override
  TaskEither<AppException, List<AnswerHistory>> getAnswerHistories() =>
      TaskEither.tryCatch(
        () async {
          return localDB
              .all<RealmAnswerHistory>()
              .map((e) => e.toAnswerHistory())
              .toList();
        },
        (e, _) => AppException.fromRawException(e: e),
      );
}
