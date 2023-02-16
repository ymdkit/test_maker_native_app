import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';
import 'package:test_maker_native_app/state/questions_state.dart';

final workbooksProvider = StateNotifierProvider.autoDispose
    .family<WorkbooksStateNotifier, List<Workbook>, String?>(
  (ref, folderId) => WorkbooksStateNotifier(
    folderId: folderId,
    workbookRepository: ref.watch(workbookRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
    onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<List<Workbook>> {
  WorkbooksStateNotifier({
    required this.folderId,
    required this.workbookRepository,
    required this.onMutateWorkbookStream,
    required StreamController<Question> onMutateQuestionStream,
  }) : super(workbookRepository.getWorkbooks(folderId)) {
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) => state = workbookRepository.getWorkbooks(folderId),
    );
  }

  final String? folderId;
  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateWorkbookStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;

  Workbook addWorkbook({
    required String title,
    required ColorTheme color,
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
    required ColorTheme color,
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
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateWorkbookStreamProvider = Provider(
  (ref) => StreamController<Workbook>.broadcast(),
);
