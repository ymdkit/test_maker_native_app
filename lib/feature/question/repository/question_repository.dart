import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/data/local/realm.dart';
import 'package:test_maker_native_app/data/remote/firebase_auth.dart';
import 'package:test_maker_native_app/data/remote/firestore.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/repository/local_question_repository.dart';
import 'package:test_maker_native_app/feature/question/repository/remote_owned_question_repository.dart';
import 'package:test_maker_native_app/feature/question/repository/remote_shared_question_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final questionRepositoryProvider =
    Provider.family<QuestionRepository, AppDataLocation>((ref, location) {
  switch (location) {
    case AppDataLocation.local:
      return LocalQuestionRepository(localDB: ref.watch(realmProvider));
    case AppDataLocation.remoteOwned:
      return RemoteOwnedQuestionRepository(
        remoteDB: ref.watch(firestoreProvider),
        auth: ref.watch(firebaseAuthProvider),
      );
    case AppDataLocation.remoteShared:
      return RemoteSharedQuestionRepository(
        remoteDB: ref.watch(firestoreProvider),
      );
  }
});

abstract class QuestionRepository {
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
  });

  Future<Either<AppException, List<Question>>> addQuestions(
    List<Question> questions,
  );

  Future<Either<AppException, List<Question>>> getQuestions(
    String workbookId,
  );

  Future<Either<AppException, List<Question>>> getDeletedQuestions();

  Future<Either<AppException, void>> updateQuestion(Question question);

  Future<Either<AppException, void>> deleteQuestion(Question question);

  Future<Either<AppException, void>> deleteQuestions(List<Question> questions);

  Future<Either<AppException, void>> destroyQuestions(List<Question> questions);

  Future<Either<AppException, void>> restoreQuestion(Question question);
}
