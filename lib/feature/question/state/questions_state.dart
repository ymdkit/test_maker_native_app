import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/repository/question_repository.dart';

final questionsProvider = StateNotifierProvider.family<QuestionsStateNotifier,
    List<Question>, String>(
  (ref, workbookId) {
    return QuestionsStateNotifier(
      questionRepository: ref.watch(questionRepositoryProvider),
      workbookId: workbookId,
      onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    );
  },
);

class QuestionsStateNotifier extends StateNotifier<List<Question>> {
  QuestionsStateNotifier({
    required this.questionRepository,
    required this.workbookId,
    required this.onMutateQuestionStream,
  }) : super(questionRepository.getQuestions(workbookId)) {
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) => state = questionRepository.getQuestions(workbookId),
    );
  }

  final QuestionRepository questionRepository;
  final String workbookId;
  final StreamController<Question> onMutateQuestionStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;

  void addQuestion({
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
  }) {
    final question = questionRepository.addQuestion(
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
    state = [...state, question];
    onMutateQuestionStream.sink.add(question);
  }

  void updateQuestion({
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
  }) {
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

    questionRepository.updateQuestion(newQuestion);
    state = state.map((e) {
      if (e.questionId == newQuestion.questionId) {
        return newQuestion;
      } else {
        return e;
      }
    }).toList();
    onMutateQuestionStream.sink.add(newQuestion);
  }

  void deleteQuestion(Question question) {
    questionRepository.deleteQuestion(question);
    state = state.where((e) => e.questionId != question.questionId).toList();
    onMutateQuestionStream.sink.add(question);
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