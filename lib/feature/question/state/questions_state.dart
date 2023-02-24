import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

typedef QuestionsState = AppAsyncState<List<Question>>;

final questionsProvider = StateNotifierProvider.family<QuestionsStateNotifier,
    QuestionsState, String>(
  (ref, workbookId) {
    return QuestionsStateNotifier(
      questionRepository: ref.watch(questionRepositoryProvider),
      workbookId: workbookId,
      onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    );
  },
);

class QuestionsStateNotifier extends StateNotifier<QuestionsState> {
  QuestionsStateNotifier({
    required this.questionRepository,
    required this.workbookId,
    required this.onMutateQuestionStream,
  }) : super(const QuestionsState.loading()) {
    setupQuestions();
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) => setupQuestions(),
    );
  }

  final QuestionRepository questionRepository;
  final String workbookId;
  final StreamController<Question> onMutateQuestionStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;

  Future<void> setupQuestions() async {
    state = const QuestionsState.loading();
    final result = await questionRepository.getQuestions(workbookId);
    result.match(
      (l) => state = QuestionsState.failure(exception: l),
      (r) => state = QuestionsState.success(value: r),
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

  @override
  void dispose() {
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateQuestionStreamProvider = Provider(
  (ref) => StreamController<Question>.broadcast(),
);
