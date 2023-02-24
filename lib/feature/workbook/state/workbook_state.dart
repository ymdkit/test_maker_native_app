import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/local_workbooks_state.dart';

part 'workbook_state.g.dart';

@riverpod
Workbook workbook(
  WorkbookRef ref, {
  required String? folderId,
  required String workbookId,
}) {
  final workbooksState = ref.watch(localWorkbooksProvider(folderId));
  return workbooksState.maybeWhen(
    orElse: () => Workbook.empty(),
    success: (workbooks) =>
        workbooks.firstWhereOrNull((e) => e.workbookId == workbookId) ??
        Workbook.empty(),
  );
}
