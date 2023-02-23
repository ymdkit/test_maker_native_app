import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';

part 'workbook.freezed.dart';

@freezed
class Workbook with _$Workbook {
  const Workbook._();
  const factory Workbook({
    required String workbookId,
    required String title,
    required int order,
    required AppThemeColor color,
    required String? folderId,
    required int questionCount,
  }) = _Workbook;

  factory Workbook.empty() => const Workbook(
        workbookId: '',
        title: '削除済み問題集',
        order: 0,
        color: AppThemeColor.blue,
        folderId: null,
        questionCount: 0,
      );
}
