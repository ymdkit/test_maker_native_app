import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/utils/app_image.dart';

part 'import_question_response.g.dart';

@JsonSerializable()
class ImportQuestionResponse {
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

  ImportQuestionResponse({
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

  factory ImportQuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$ImportQuestionResponseFromJson(json);

  Question toQuestion({
    required String workbookId,
    required AppDataLocation location,
  }) {
    return Question(
      questionId: '',
      workbookId: workbookId,
      questionType:
          QuestionType.values.elementAtOrDefault(type, QuestionType.write),
      problem: question,
      problemImage: const AppImage.empty(),
      answers: answers.isNotEmpty ? answers : [answer],
      wrongChoices: others,
      explanation: explanation,
      explanationImage: const AppImage.empty(),
      isAutoGenerateWrongChoices: isAutoGenerateOthers,
      isCheckAnswerOrder: isCheckOrder,
      order: order,
      answerStatus: AnswerStatus.unAnswered,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastAnsweredAt: null,
      location: location,
    );
  }
}
