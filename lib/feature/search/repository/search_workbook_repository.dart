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
        // final body = [
        //   {
        //     'id': 186255,
        //     'name': 'No.36',
        //     'color': 0,
        //     'document_id': 'tC2mdC0NLpH55J2NfUOD',
        //     'size': 9,
        //     'comment': '',
        //     'user_id': 'XHwWxb8TqmdI45Oh5o6xGwTaYlf2',
        //     'user_name': '加藤朱夏',
        //     'created_at': {
        //       'secs_since_epoch': 1677158921,
        //       'nanos_since_epoch': 0
        //     },
        //     'updated_at': {
        //       'secs_since_epoch': 1677158921,
        //       'nanos_since_epoch': 0
        //     },
        //     'download_count': 0,
        //     'answer_count': 0,
        //   }
        // ];
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
      print(e);
      return Left(AppException.fromRawException(e: e));
    }
  }
}
