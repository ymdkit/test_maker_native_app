import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/search/repository/search_workbook_repository.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

final searchWorkbooksProvider = FutureProvider.autoDispose<List<Workbook>>(
  (ref) async {
    final repository = ref.watch(searchWorkbooksRepositoryProvider);
    final query = ref.watch(searchWorkbooksQueryProvider);
    final result = await repository.searchWorkbooks(query: query);

    return result.match(
      (l) => throw l,
      (r) => r,
    );
  },
);

final searchWorkbooksQueryProvider =
    StateProvider.autoDispose<String>((ref) => '');
