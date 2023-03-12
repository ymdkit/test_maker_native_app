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
import 'package:test_maker_native_app/utils/app_image.dart';

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
    required AppImage problemImage,
    required List<String> answers,
    required List<String> wrongChoices,
    required String? explanation,
    required AppImage explanationImage,
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
      problemImage: problemImage,
      answers: answers,
      wrongChoices: wrongChoices,
      explanation: explanation,
      explanationImage: explanationImage,
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
  TaskEither<AppException, List<Question>> addQuestions(
      List<Question> questions) {
    return TaskEither.tryCatch(
      () async {
        localDB.write(() {
          for (final question in questions) {
            final questionId = Uuid.v4().toString();
            localDB.add<RealmQuestion>(
              RealmQuestionConverting.fromQuestion(
                question.copyWith(
                  questionId: questionId,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              ),
            );
          }
        });
        return questions;
      },
      (e, _) => AppException.fromRawException(e: e),
    );
  }

  @override
  TaskEither<AppException, List<Question>> getQuestions(
    String workbookId,
  ) =>
      TaskEither.tryCatch(
        () async {
          return localDB
              .all<RealmQuestion>()
              .where((e) => e.workbookId == workbookId)
              .where((e) => e.isDeleted != true)
              .map((e) => e.toQuestion())
              .toList();
        },
        (e, s) => AppException.fromRawException(e: e),
      );

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
  TaskEither<AppException, void> deleteQuestions(List<Question> questions) {
    return TaskEither.tryCatch(
      () => localDB.write(
        () async {
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
