import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';

part 'questions_state_key.freezed.dart';

@freezed
class QuestionsStateKey with _$QuestionsStateKey {
  const QuestionsStateKey._();
  const factory QuestionsStateKey({
    required AppDataLocation location,
    required String workbookId,
  }) = _QuestionsStateKey;

  factory QuestionsStateKey.from(
    Question question,
  ) =>
      QuestionsStateKey(
        location: question.location,
        workbookId: question.workbookId,
      );
}
