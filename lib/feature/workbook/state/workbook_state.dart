import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';

part 'workbook_state.g.dart';

@riverpod
Workbook workbook(
  WorkbookRef ref, {
  required String? folderId,
  required String workbookId,
}) {
  final workbooks = ref.watch(workbooksProvider(folderId));
  return workbooks.firstWhere((e) => e.workbookId == workbookId);
}
