import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';

final workbooksProvider = StateNotifierProvider.autoDispose
    .family<WorkbooksStateNotifier, List<Workbook>, String?>(
  (ref, folderId) => WorkbooksStateNotifier(
    folderId: folderId,
    workbookRepository: ref.watch(workbookRepositoryProvider),
    onMutateWorkbookStream: ref.watch(onMutateWorkbookStreamProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<List<Workbook>> {
  WorkbooksStateNotifier({
    required this.folderId,
    required this.workbookRepository,
    required this.onMutateWorkbookStream,
  }) : super(workbookRepository.getWorkbooks(folderId));

  final String? folderId;
  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateWorkbookStream;

  void addWorkbook({
    required String title,
    required ColorTheme color,
    required String? folderId,
  }) {
    final newWorkbook = workbookRepository.addWorkbook(
      title: title,
      color: color,
      folderId: folderId,
    );
    state = [...state, newWorkbook];
    onMutateWorkbookStream.sink.add(newWorkbook);
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
}

final onMutateWorkbookStreamProvider = Provider(
  (ref) => StreamController<Workbook>.broadcast(),
);
