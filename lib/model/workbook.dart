import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/model/question.dart';

part 'workbook.freezed.dart';

@freezed
class Workbook with _$Workbook {
  const factory Workbook({
    required String workbookId,
    required String title,
    required int order,
    required int color,
    required List<Question> questions,
  }) = _Workbook;
}
