import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/model/enum/answer_status.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
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
  }) = _Question;
}
