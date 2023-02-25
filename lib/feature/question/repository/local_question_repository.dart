import 'package:dartx/dartx.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/data/local/realm_model_converting_ext.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class LocalQuestionRepository implements QuestionRepository {
  LocalQuestionRepository({
    required this.localDB,
  });

  final Realm localDB;

  @override
  Future<Either<AppException, Question>> addQuestion({
    required String workbookId,
    required QuestionType questionType,
    required String problem,
    required String? problemImageUrl,
    required List<String> answers,
    required List<String> wrongChoices,
    required String? explanation,
    required String? explanationImageUrl,
    required bool isAutoGenerateWrongChoices,
    required bool isCheckAnswerOrder,
  }) async {
    final newOrder =
        (localDB.all<RealmQuestion>().maxBy((e) => e.order)?.order ?? 0) + 1;

    final question = Question.from(
      questionId: Uuid.v4().toString(),
      questionType: questionType,
      workbookId: workbookId,
      problem: problem,
      problemImageUrl: problemImageUrl,
      answers: answers,
      wrongChoices: wrongChoices,
      explanation: explanation,
      explanationImageUrl: explanationImageUrl,
      isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
      isCheckAnswerOrder: isCheckAnswerOrder,
      order: newOrder,
      answerStatus: AnswerStatus.unAnswered,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastAnsweredAt: null,
      location: AppDataLocation.local,
    );

    localDB.write(() {
      localDB.add<RealmQuestion>(
        RealmQuestionConverting.fromQuestion(question),
      );
    });

    return Right(question);
  }

  @override
  Future<Either<AppException, List<Question>>> addQuestions(
      List<Question> questions) async {
    return TaskEither.tryCatch(
      () async {
        localDB.write(() {
          for (final question in questions) {
            localDB.add<RealmQuestion>(
              RealmQuestionConverting.fromQuestion(question),
            );
          }
        });
        return questions;
      },
      (e, _) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Question>>> getQuestions(
    String workbookId,
  ) async {
    return Right(localDB
        .all<RealmQuestion>()
        .where((e) => e.workbookId == workbookId)
        .where((e) => e.isDeleted != true)
        .map((e) => e.toQuestion())
        .toList());
  }

  @override
  Future<Either<AppException, List<Question>>> getDeletedQuestions() async {
    return Right(localDB
        .all<RealmQuestion>()
        .where((e) => e.isDeleted == true)
        .map((e) => e.toQuestion())
        .toList());
  }

  @override
  Future<Either<AppException, void>> updateQuestion(Question question) async {
    localDB.write(() {
      localDB.add<RealmQuestion>(
        RealmQuestionConverting.fromQuestion(
          question.copyWith(
            updatedAt: DateTime.now(),
          ),
        ),
        update: true,
      );
    });
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> deleteQuestion(Question question) async {
    localDB.write(
      () {
        localDB.add<RealmQuestion>(
          RealmQuestionConverting.fromQuestion(question)..isDeleted = true,
          update: true,
        );
      },
    );
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> deleteQuestions(
      List<Question> questions) async {
    return Either.tryCatch(
      () => localDB.write(
        () {
          final targets = localDB.all<RealmQuestion>().where((e) {
            return questions
                .any((element) => element.questionId == e.questionId);
          }).toList();
          localDB.addAll(
            targets.map((e) => e..isDeleted = true).toList(),
          );
        },
      ),
      (e, s) => AppException.fromRawException(e: e),
    );
  }

  @override
  Future<Either<AppException, void>> destroyQuestions(
      List<Question> questions) async {
    localDB.write(
      () {
        final targets = localDB.all<RealmQuestion>().where((e) {
          return questions.any((element) => element.questionId == e.questionId);
        }).toList();
        localDB.deleteMany<RealmQuestion>(targets);
      },
    );
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> restoreQuestion(Question question) async {
    localDB.write(
      () {
        localDB.add<RealmQuestion>(
          RealmQuestionConverting.fromQuestion(question)..isDeleted = false,
          update: true,
        );
      },
    );
    return const Right(null);
  }
}
