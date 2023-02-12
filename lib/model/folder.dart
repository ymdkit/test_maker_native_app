import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required String folderId,
    required String title,
    required int order,
    required int color,
  }) = _Folder;
}
