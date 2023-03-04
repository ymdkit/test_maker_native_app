import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_history.freezed.dart';

@freezed
class AnswerHistory with _$AnswerHistory {
  const AnswerHistory._();

  const factory AnswerHistory({
    required String answerHistoryId,
    required String questionId,
    required String workbookId,
    required bool isCorrect,
    required DateTime createdAt,
  }) = _AnswerHistory;
}
