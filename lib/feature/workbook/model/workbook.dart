import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';

part 'workbook.freezed.dart';

@freezed
class Workbook with _$Workbook {
  const factory Workbook({
    required String workbookId,
    required String title,
    required int order,
    required AppThemeColor color,
    required String? folderId,
    required int questionCount,
  }) = _Workbook;
}
