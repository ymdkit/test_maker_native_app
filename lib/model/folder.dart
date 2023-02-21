import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required String folderId,
    required String title,
    required int order,
    required AppThemeColor color,
    required int workbookCount,
  }) = _Folder;
}
