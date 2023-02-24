import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/constants/data_source.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

part 'search_workbook_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchWorkbookResponse {
  final String documentId;
  final String name;
  final int color;
  final int size;
  final String userId;
  final String userName;
  @EpochDateTimeConverter()
  final DateTime createdAt;
  @EpochDateTimeConverter()
  final DateTime updatedAt;

  SearchWorkbookResponse({
    required this.documentId,
    required this.name,
    required this.color,
    required this.size,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SearchWorkbookResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchWorkbookResponseFromJson(json);

  Workbook toWorkbook() => Workbook(
        workbookId: documentId,
        title: name,
        color:
            AppThemeColor.values.elementAtOrNull(color) ?? AppThemeColor.blue,
        questionCount: size,
        createdAt: createdAt,
        updatedAt: updatedAt,
        order: 0,
        folderId: null,
        location: AppDataLocation.remoteShared,
      );
}

class EpochDateTimeConverter
    implements JsonConverter<DateTime, Map<String, dynamic>> {
  const EpochDateTimeConverter();

  @override
  DateTime fromJson(Map<String, dynamic> json) =>
      DateTime.fromMillisecondsSinceEpoch(json['secs_since_epoch'] as int);

  @override
  Map<String, dynamic> toJson(DateTime object) =>
      {'secs_since_epoch': object.millisecondsSinceEpoch};
}
