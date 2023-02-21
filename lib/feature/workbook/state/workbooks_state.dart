import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';

final workbooksProvider = StateNotifierProvider.autoDispose
    .family<WorkbooksStateNotifier, List<Workbook>, String?>(
  (ref, folderId) => WorkbooksStateNotifier(
    folderId: folderId,
    workbookRepository: ref.watch(workbookRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    onMutateDeletedWorkbookStream:
        ref.watch(onMutateDeletedWorkbookStreamProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<List<Workbook>> {
  WorkbooksStateNotifier({
    required this.folderId,
    required this.workbookRepository,
    required this.onMutateWorkbookStream,
    required StreamController<Question> onMutateQuestionStream,
    required StreamController<Workbook> onMutateDeletedWorkbookStream,
  }) : super(workbookRepository.getWorkbooks(folderId)) {
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) => state = workbookRepository.getWorkbooks(folderId),
    );
    onMutateDeletedWorkbookSubscription =
        onMutateDeletedWorkbookStream.stream.listen(
      (workbook) => state = workbookRepository.getWorkbooks(folderId),
    );
  }

  final String? folderId;
  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateWorkbookStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;
  late final StreamSubscription<Workbook> onMutateDeletedWorkbookSubscription;

  Workbook addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) {
    final newWorkbook = workbookRepository.addWorkbook(
      title: title,
      color: color,
      folderId: folderId,
    );

    if (this.folderId == folderId) {
      state = [...state, newWorkbook];
    }
    onMutateWorkbookStream.sink.add(newWorkbook);
    return newWorkbook;
  }

  void updateWorkbook({
    required Workbook currentWorkbook,
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) {
    final updatedWorkbook = currentWorkbook.copyWith(
      title: title,
      color: color,
      folderId: folderId,
    );
    workbookRepository.updateWorkbook(updatedWorkbook);

    state = state.map(
      (e) {
        if (e.workbookId == updatedWorkbook.workbookId) {
          return updatedWorkbook;
        } else {
          return e;
        }
      },
    ).toList();
    onMutateWorkbookStream.sink.add(updatedWorkbook);
  }

  void deleteWorkbook(Workbook workbook) {
    workbookRepository.deleteWorkbook(workbook);
    state = state.where((e) => e.workbookId != workbook.workbookId).toList();
    onMutateWorkbookStream.sink.add(workbook);
  }

  @override
  void dispose() {
    onMutateDeletedWorkbookSubscription.cancel();
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateWorkbookStreamProvider = Provider(
  (ref) => StreamController<Workbook>.broadcast(),
);
