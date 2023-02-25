import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_questions_state.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

typedef QuestionsState = AppAsyncState<List<Question>>;

final questionsProvider = StateNotifierProvider.autoDispose
    .family<QuestionsStateNotifier, QuestionsState, QuestionsStateKey>(
  (ref, key) {
    return QuestionsStateNotifier(
      questionRepository: ref.watch(questionRepositoryProvider(key.location)),
      workbookId: key.workbookId,
      query: ref.watch(questionsQueryProvider),
      onMutateQuestionStream:
          ref.watch(onMutateQuestionStreamProvider(key.location)),
      onMutateDeletedQuestionStream:
          ref.watch(onMutateDeletedQuestionStreamProvider(key.location)),
    );
  },
);

final questionsQueryProvider = StateProvider.autoDispose<String>((ref) => '');

class QuestionsStateNotifier extends StateNotifier<QuestionsState> {
  QuestionsStateNotifier({
    required this.questionRepository,
    required this.workbookId,
    required this.query,
    required this.onMutateQuestionStream,
    required StreamController<Question> onMutateDeletedQuestionStream,
  }) : super(const QuestionsState.loading()) {
    setupQuestions(query);
    onDeletedMutateQuestionSubscription =
        onMutateDeletedQuestionStream.stream.listen(
      (question) => setupQuestions(query),
    );
  }

  final QuestionRepository questionRepository;
  final String workbookId;
  final String query;
  final StreamController<Question> onMutateQuestionStream;
  late final StreamSubscription<Question> onDeletedMutateQuestionSubscription;

  Future<void> setupQuestions(String query) async {
    state = const QuestionsState.loading();
    final result = await questionRepository.getQuestions(workbookId);
    result.match(
      (l) => state = QuestionsState.failure(exception: l),
      (r) => state = QuestionsState.success(
        value: r
            .where(
              (e) =>
                  e.problem.contains(query) ||
                  e.answers.any((e) => e.contains(query)) ||
                  e.wrongChoices.any((e) => e.contains(query)) ||
                  (e.explanation?.contains(query) ?? false),
            )
            .toList(),
      ),
    );
  }

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
    final result = await questionRepository.addQuestion(
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
    );

    return result.match(
      (l) => left(l),
      (r) {
        if (this.workbookId == workbookId) {
          state.maybeWhen(
            success: (questions) => state = QuestionsState.success(
              value: [...questions, r],
            ),
            orElse: () {},
          );
        }
        onMutateQuestionStream.sink.add(r);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> updateQuestion({
    required Question currentQuestion,
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
    final newQuestion = currentQuestion.copyWith(
      questionType: questionType,
      problem: problem,
      problemImageUrl: problemImageUrl,
      answers: answers,
      wrongChoices: wrongChoices,
      explanation: explanation,
      explanationImageUrl: explanationImageUrl,
      isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
      isCheckAnswerOrder: isCheckAnswerOrder,
    );

    final result = await questionRepository.updateQuestion(newQuestion);

    return result.match(
      (l) => left(l),
      (r) {
        if (newQuestion.workbookId == workbookId) {
          state.maybeWhen(
            success: (questions) => state = QuestionsState.success(
              value: questions.map(
                (e) {
                  if (e.questionId == newQuestion.questionId) {
                    return newQuestion;
                  } else {
                    return e;
                  }
                },
              ).toList(),
            ),
            orElse: () {},
          );
        }
        onMutateQuestionStream.sink.add(newQuestion);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> deleteQuestion(Question question) async {
    final result = await questionRepository.deleteQuestion(question);
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (questions) {
            state = QuestionsState.success(
              value: questions
                  .where((e) => e.questionId != question.questionId)
                  .toList(),
            );
            onMutateQuestionStream.sink.add(question);
          },
          orElse: () {},
        );

        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> deleteQuestions(
      List<Question> question) async {
    final result = await questionRepository.deleteQuestions(question);
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (questions) {
            state = QuestionsState.success(
              value: questions
                  .where(
                      (e) => !question.any((q) => q.questionId == e.questionId))
                  .toList(),
            );
            if (questions.isNotEmpty) {
              onMutateQuestionStream.sink.add(questions.first);
            }
          },
          orElse: () {},
        );

        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> copyQuestions({
    required String destWorkbookId,
    required List<Question> questions,
  }) async {
    final result = await questionRepository.addQuestions(
      questions.map((e) => e.copyWith(workbookId: destWorkbookId)).toList(),
    );
    return result.match(
      (l) => left(l),
      (r) {
        if (r.isNotEmpty) {
          onMutateQuestionStream.sink.add(r.first);
        }
        return right(null);
      },
    );
  }

  @override
  void dispose() {
    onDeletedMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateQuestionStreamProvider =
    Provider.family<StreamController<Question>, AppDataLocation>(
  (ref, _) => StreamController<Question>.broadcast(),
);
