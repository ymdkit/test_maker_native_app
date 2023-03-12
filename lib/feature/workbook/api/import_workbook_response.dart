import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/feature/workbook/api/import_question_response.dart';

part 'import_workbook_response.g.dart';

@JsonSerializable()
class ImportWorkbookResponse {
  final String title;
  final List<ImportQuestionResponse> questions;

  ImportWorkbookResponse({
    required this.title,
    required this.questions,
  });

  factory ImportWorkbookResponse.fromJson(Map<String, dynamic> json) =>
      _$ImportWorkbookResponseFromJson(json);
}
