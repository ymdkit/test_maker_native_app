import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';

final deletedWorkbooksProvider =
    StateNotifierProvider.autoDispose<WorkbooksStateNotifier, List<Workbook>>(
  (ref) => WorkbooksStateNotifier(
    workbookRepository: ref.watch(workbookRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateDeletedWorkbookStream:
        ref.watch(onMutateDeletedWorkbookStreamProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<List<Workbook>> {
  WorkbooksStateNotifier({
    required this.workbookRepository,
    required this.onMutateDeletedWorkbookStream,
    required StreamController<Workbook> onMutateWorkbookStream,
  }) : super(workbookRepository.getDeletedWorkbooks()) {
    onMutateWorkbookSubscription = onMutateWorkbookStream.stream.listen(
      (workbook) => state = workbookRepository.getDeletedWorkbooks(),
    );
  }

  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateDeletedWorkbookStream;
  late final StreamSubscription<Workbook> onMutateWorkbookSubscription;

  void restoreWorkbook(Workbook workbook) {
    workbookRepository.restoreWorkbook(workbook);
    state = state.where((e) => e.workbookId != workbook.workbookId).toList();
    onMutateDeletedWorkbookStream.sink.add(workbook);
  }

  @override
  void dispose() {
    onMutateWorkbookSubscription.cancel();
    super.dispose();
  }
}

final onMutateDeletedWorkbookStreamProvider = Provider(
  (ref) => StreamController<Workbook>.broadcast(),
);
