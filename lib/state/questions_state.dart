import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/repository/question_repository.dart';

final questionsProvider = StateNotifierProvider.family<QuestionsStateNotifier,
    List<Question>, String>(
  (ref, workbookId) {
    final questionRepository = ref.watch(questionRepositoryProvider);
    return QuestionsStateNotifier(
      questionRepository: questionRepository,
      workbookId: workbookId,
    );
  },
);

class QuestionsStateNotifier extends StateNotifier<List<Question>> {
  QuestionsStateNotifier({
    required this.questionRepository,
    required this.workbookId,
  }) : super(questionRepository.getQuestions(workbookId));

  final QuestionRepository questionRepository;
  final String workbookId;

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
  }

  void updateQuestion({
    required Question currentQuestion,
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
  }

  void deleteQuestion(Question question) {
    questionRepository.deleteQuestion(question);
    state = state.where((e) => e.questionId != question.questionId).toList();
  }
}
