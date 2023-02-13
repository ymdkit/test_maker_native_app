import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/repository/workbook_repository.dart';

final workbookProvider = Provider.family<Workbook, String>(
  (ref, workbookId) {
    final workbookRepository = ref.watch(workbookRepositoryProvider);
    return workbookRepository.getWorkbook(workbookId);
  },
);
