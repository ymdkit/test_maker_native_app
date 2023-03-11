import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/record/model/answer_history.dart';
import 'package:test_maker_native_app/feature/record/repository/answer_history_repository.dart';

class LocalAnswerHistoryRepository implements AnswerHistoryRepository {
  LocalAnswerHistoryRepository({
    required this.localDB,
  });

  final Realm localDB;

  @override
  AnswerHistory addAnswerHistory({
    required String workbookId,
    required String questionId,
    required bool isCorrect,
  }) {
    final nerAnswerHistory = AnswerHistory(
      answerHistoryId: Uuid.v4().toString(),
      workbookId: workbookId,
      questionId: questionId,
      isCorrect: isCorrect,
      createdAt: DateTime.now(),
    );

    localDB.write(() {
      localDB.add<RealmAnswerHistory>(
          RealmAnswerHistoryConverting.fromAnswerHistory(nerAnswerHistory));
    });
    return nerAnswerHistory;
  }

  @override
  List<AnswerHistory> getAnswerHistories({
    String? questionId,
  }) {
    if (questionId != null) {
      return localDB
          .query<RealmAnswerHistory>(r'questionId == $0', [questionId])
          .map((e) => e.toAnswerHistory())
          .toList();
    } else {
      return localDB
          .all<RealmAnswerHistory>()
          .map((e) => e.toAnswerHistory())
          .toList();
    }
  }
}
