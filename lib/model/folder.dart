import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/model/workbook.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required String folderId,
    required String title,
    required int order,
    required int color,
    required List<Workbook> workbooks,
  }) = _Folder;
}
