import 'package:freezed_annotation/freezed_annotation.dart';

part 'export_workbook_response.g.dart';

@JsonSerializable()
class ExportWorkbookResponse {
  final String text;

  ExportWorkbookResponse({
    required this.text,
  });

  factory ExportWorkbookResponse.fromJson(Map<String, dynamic> json) =>
      _$ExportWorkbookResponseFromJson(json);
}
