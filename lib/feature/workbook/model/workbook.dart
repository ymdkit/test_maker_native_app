import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
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
    required DateTime createdAt,
    required DateTime updatedAt,
    required AppDataLocation location,
  }) = _Workbook;

  bool get isOwned =>
      location == AppDataLocation.local ||
      location == AppDataLocation.remoteOwned;

  factory Workbook.empty() => Workbook(
        workbookId: '',
        title: '',
        order: 0,
        color: AppThemeColor.blue,
        folderId: null,
        questionCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        location: AppDataLocation.local,
      );
}
