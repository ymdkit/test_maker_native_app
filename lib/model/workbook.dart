import 'package:freezed_annotation/freezed_annotation.dart';

part 'workbook.freezed.dart';

@freezed
class Workbook with _$Workbook {
  const factory Workbook({
    required String workbookId,
    required String title,
    required int order,
    required int color,
    required String? folderId,
  }) = _Workbook;
}
