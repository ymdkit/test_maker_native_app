import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

part 'workbooks_state_key.freezed.dart';

@freezed
class WorkbooksStateKey with _$WorkbooksStateKey {
  const WorkbooksStateKey._();
  const factory WorkbooksStateKey({
    required AppDataLocation location,
    required String? folderId,
  }) = _WorkbooksStateKey;

  factory WorkbooksStateKey.from(
    Workbook workbook,
  ) =>
      WorkbooksStateKey(
        location: workbook.location,
        folderId: workbook.folderId,
      );
}
