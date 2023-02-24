import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/group/repository/group_repository.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

final groupWorkbooksStateProvider =
    FutureProvider.autoDispose.family<List<Workbook>, String>(
  (ref, groupId) async {
    final repository = ref.watch(groupRepositoryProvider);
    final result = await repository.getGroupWorkbooks(groupId: groupId);

    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  },
);
