import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:realm/realm.dart' hide AppException;
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/data/remote/firestore_converting.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class RemoteOwnedQuestionRepository implements QuestionRepository {
  RemoteOwnedQuestionRepository({
    required this.auth,
    required this.remoteDB,
  });

  final FirebaseAuth auth;
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
    return TaskEither.tryCatch(
      () async {
        final questionId = Uuid.v4().toString();

        final question = Question(
          questionId: questionId,
          workbookId: workbookId,
          questionType: questionType,
          problem: problem,
          problemImageUrl: problemImageUrl,
          answers: answers,
          wrongChoices: wrongChoices,
          explanation: explanation,
          explanationImageUrl: explanationImageUrl,
          isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
          isCheckAnswerOrder: isCheckAnswerOrder,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          lastAnsweredAt: null,
          location: AppDataLocation.remoteOwned,
          order: -1,
          answerStatus: AnswerStatus.unAnswered,
        );

        await remoteDB
            .collection('tests')
            .doc(workbookId)
            .collection('questions')
            .doc(questionId)
            .set({
          'documentId': questionId,
          'type': question.questionType.index,
          'question': question.problem,
          'answers': question.answers,
          'answer': question.answers.firstOrNull ?? '',
          'others': question.wrongChoices,
          'auto': question.isAutoGenerateWrongChoices,
          'checkOrder': question.isCheckAnswerOrder,
          'order': question.order,
          'createdAt': Timestamp.now(),
          'updatedAt': Timestamp.now(),
          'imageRef': question.problemImageUrl,
          'explanation': question.explanation,
          'explanationImageRef': question.explanationImageUrl,
        });

        await _updateWorkbookSize(workbookId: question.workbookId);

        return Future.value(question);
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, List<Question>>> addQuestions(
      List<Question> questions) async {
    return TaskEither.tryCatch(
      () async {
        final batch = remoteDB.batch();

        for (final question in questions) {
          final questionId = Uuid.v4().toString();

          batch.set(
            remoteDB
                .collection('tests')
                .doc(question.workbookId)
                .collection('questions')
                .doc(questionId),
            {
              'documentId': questionId,
              'type': question.questionType.index,
              'question': question.problem,
              'answers': question.answers,
              'answer': question.answers.firstOrNull ?? '',
              'others': question.wrongChoices,
              'auto': question.isAutoGenerateWrongChoices,
              'checkOrder': question.isCheckAnswerOrder,
              'order': question.order,
              'createdAt': Timestamp.now(),
              'updatedAt': Timestamp.now(),
              'imageRef': question.problemImageUrl,
              'explanation': question.explanation,
              'explanationImageRef': question.explanationImageUrl,
            },
          );
        }

        await batch.commit();

        await _updateWorkbookSize(workbookId: questions.first.workbookId);

        return questions;
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
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
            .get()
            .then((value) => value.docs
                .where(
                    (e) => e.data().getOrElse('deleted', () => false) == false)
                .map((e) => documentToQuestion(
                      isOwned: true,
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
    return TaskEither.tryCatch(
      () async {
        return remoteDB
            .collection('tests')
            .doc(question.workbookId)
            .collection('questions')
            .doc(question.questionId)
            .update({
          'question': question.problem,
          'answers': question.answers,
          'answer': question.answers.firstOrNull ?? '',
          'others': question.wrongChoices,
          'auto': question.isAutoGenerateWrongChoices,
          'checkOrder': question.isCheckAnswerOrder,
          'order': question.order,
          'updatedAt': Timestamp.now(),
          'imageRef': question.problemImageUrl,
          'explanation': question.explanation,
          'explanationImageRef': question.explanationImageUrl,
        }).then((value) => null);
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> deleteQuestion(Question question) async {
    return TaskEither.tryCatch(
      () async {
        await remoteDB
            .collection('tests')
            .doc(question.workbookId)
            .collection('questions')
            .doc(question.questionId)
            .update({'deleted': true});

        await _updateWorkbookSize(workbookId: question.workbookId);
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
  }

  @override
  Future<Either<AppException, void>> deleteQuestions(
      List<Question> questions) async {
    return TaskEither.tryCatch(
      () async {
        final batch = remoteDB.batch();

        for (final question in questions) {
          batch.update(
            remoteDB
                .collection('tests')
                .doc(question.workbookId)
                .collection('questions')
                .doc(question.questionId),
            {'deleted': true},
          );
        }

        await batch.commit();
        if (questions.isNotEmpty) {
          await _updateWorkbookSize(workbookId: questions.first.workbookId);
        }
      },
      (e, stack) => AppException.fromRawException(e: e),
    ).run();
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

  Future<void> _updateWorkbookSize({
    required String workbookId,
  }) async {
    final questionsCount = await remoteDB
        .collection('tests')
        .doc(workbookId)
        .collection('questions')
        .get()
        .then(
          (value) => value.docs
              .where((e) => e.data().getOrElse('deleted', () => false) == false)
              .count(),
        );

    await remoteDB.collection('tests').doc(workbookId).update({
      'size': questionsCount,
    });
  }
}
