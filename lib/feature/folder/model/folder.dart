import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const Folder._();
  const factory Folder({
    required String folderId,
    required String title,
    required int order,
    required AppThemeColor color,
    required int workbookCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    required AppDataLocation location,
  }) = _Folder;

  factory Folder.empty() => Folder(
        folderId: '',
        title: '削除済みフォルダ',
        order: 0,
        color: AppThemeColor.blue,
        workbookCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        location: AppDataLocation.local,
      );
}
