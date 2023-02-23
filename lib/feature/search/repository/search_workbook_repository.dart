import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/search/model/search_workbook_response.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final searchWorkbooksRepositoryProvider =
    Provider<SearchWorkbookRepository>((ref) {
  return SearchWorkbookRepository();
});

class SearchWorkbookRepository {
  Future<Either<AppException, List<Workbook>>> searchWorkbooks({
    required String query,
  }) async {
    final url = Uri.http('test-maker-server.herokuapp.com', 'tests', {
      'query': query,
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = json.decode(response.body) as List<dynamic>;
        final workbooks = body
            .map((e) =>
                SearchWorkbookResponse.fromJson(e as Map<String, dynamic>))
            .map((e) => e.toWorkbook())
            .toList();
        return Right(workbooks);
      } else {
        return const Left(AppException(message: '問題集の取得に失敗しました'));
      }
    } catch (e) {
      return Left(AppException.fromRawException(e: e));
    }
  }
}
