import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';

part 'export_question_request.g.dart';

@JsonSerializable()
class ExportQuestionRequest {
  final String question;
  final String answer;
  final String explanation;
  final List<String> answers;
  final List<String> others;
  final int type;
  final bool isAutoGenerateOthers;
  final int order;
  final bool isCheckOrder;
  final String imagePath;

  ExportQuestionRequest({
    required this.question,
    required this.answer,
    required this.explanation,
    required this.answers,
    required this.others,
    required this.type,
    required this.isAutoGenerateOthers,
    required this.order,
    required this.isCheckOrder,
    required this.imagePath,
  });

  factory ExportQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$ExportQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExportQuestionRequestToJson(this);

  factory ExportQuestionRequest.fromQuestion(Question question) =>
      ExportQuestionRequest(
        question: question.problem,
        answer: question.answers.first,
        explanation: question.explanation ?? '',
        answers: question.answers,
        others: question.wrongChoices,
        type: question.questionType.index,
        isAutoGenerateOthers: question.isAutoGenerateWrongChoices,
        order: question.order,
        isCheckOrder: question.isCheckAnswerOrder,
        imagePath: question.problemImage.toStringOrNull() ?? '',
      );
}
