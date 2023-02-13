import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';

final workbooksProvider = StateNotifierProvider.autoDispose
    .family<WorkbooksStateNotifier, List<Workbook>, String?>(
  (ref, folderId) => WorkbooksStateNotifier(
    folderId: folderId,
    workbookRepository: ref.watch(workbookRepositoryProvider),
  ),
);

class WorkbooksStateNotifier extends StateNotifier<List<Workbook>> {
  WorkbooksStateNotifier({
    required this.folderId,
    required this.workbookRepository,
  }) : super(workbookRepository.getWorkbooks(folderId));

  final String? folderId;
  final WorkbookRepository workbookRepository;

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
  }
}
