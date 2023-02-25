import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  const Question._();
  const factory Question({
    required String questionId,
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
    required int order,
    required AnswerStatus answerStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? lastAnsweredAt,
    required AppDataLocation location,
  }) = _Question;

  factory Question.from({
    required String questionId,
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
    required int order,
    required AnswerStatus answerStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? lastAnsweredAt,
    required AppDataLocation location,
  }) {
    switch (questionType) {
      case QuestionType.write:
        return Question(
          questionId: questionId,
          workbookId: workbookId,
          questionType: QuestionType.write,
          problem: problem,
          problemImageUrl: problemImageUrl,
          answers: [answers.first],
          wrongChoices: [],
          explanation: explanation,
          explanationImageUrl: explanationImageUrl,
          isAutoGenerateWrongChoices: false,
          isCheckAnswerOrder: false,
          order: order,
          answerStatus: answerStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastAnsweredAt: lastAnsweredAt,
          location: location,
        );
      case QuestionType.select:
        return Question(
          questionId: questionId,
          workbookId: workbookId,
          questionType: QuestionType.select,
          problem: problem,
          problemImageUrl: problemImageUrl,
          answers: [answers.first],
          wrongChoices: wrongChoices,
          explanation: explanation,
          explanationImageUrl: explanationImageUrl,
          isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
          isCheckAnswerOrder: false,
          order: order,
          answerStatus: answerStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastAnsweredAt: lastAnsweredAt,
          location: location,
        );
      case QuestionType.complete:
        return Question(
          questionId: questionId,
          workbookId: workbookId,
          questionType: QuestionType.complete,
          problem: problem,
          problemImageUrl: problemImageUrl,
          answers: answers,
          wrongChoices: [],
          explanation: explanation,
          explanationImageUrl: explanationImageUrl,
          isAutoGenerateWrongChoices: false,
          isCheckAnswerOrder: isCheckAnswerOrder,
          order: order,
          answerStatus: answerStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastAnsweredAt: lastAnsweredAt,
          location: location,
        );
      case QuestionType.selectComplete:
        return Question(
          questionId: questionId,
          workbookId: workbookId,
          questionType: QuestionType.selectComplete,
          problem: problem,
          problemImageUrl: problemImageUrl,
          answers: answers,
          wrongChoices: wrongChoices,
          explanation: explanation,
          explanationImageUrl: explanationImageUrl,
          isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
          isCheckAnswerOrder: isCheckAnswerOrder,
          order: order,
          answerStatus: answerStatus,
          createdAt: createdAt,
          updatedAt: updatedAt,
          lastAnsweredAt: lastAnsweredAt,
          location: location,
        );
    }
  }

  factory Question.empty() => Question(
        questionId: '',
        workbookId: '',
        questionType: QuestionType.write,
        problem: '',
        problemImageUrl: null,
        answers: [],
        wrongChoices: [],
        explanation: null,
        explanationImageUrl: null,
        isAutoGenerateWrongChoices: false,
        isCheckAnswerOrder: false,
        order: 0,
        answerStatus: AnswerStatus.unAnswered,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastAnsweredAt: null,
        location: AppDataLocation.local,
      );

  bool get reversible =>
      questionType == QuestionType.write ||
      questionType == QuestionType.complete;
}
