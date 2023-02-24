import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class RemoteSharedQuestionRepository implements QuestionRepository {
  RemoteSharedQuestionRepository({
    required this.remoteDB,
  });

  final FirebaseFirestore remoteDB;

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
    return Right(Question.empty());
  }

  @override
  Future<Either<AppException, List<Question>>> getQuestions(
    String workbookId,
  ) async {
    return TaskEither.tryCatch(
      () async {
        return remoteDB
            .collection('tests')
            .doc(workbookId)
            .collection('questions')
            .where('deleted', isEqualTo: null)
            .get()
            .then((value) => value.docs
                .map((e) => documentToQuestion(
                      isOwned: false,
                      workbookId: workbookId,
                      document: e,
                    ))
                .toList());
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Question>>> getDeletedQuestions() async {
    return const Right([]);
  }

  @override
  Future<Either<AppException, void>> updateQuestion(Question question) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> deleteQuestion(Question question) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> destroyQuestions(
      List<Question> questions) async {
    return const Right(null);
  }

  @override
  Future<Either<AppException, void>> restoreQuestion(Question question) async {
    return const Right(null);
  }
}
