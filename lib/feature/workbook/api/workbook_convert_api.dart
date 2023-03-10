import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/workbook/api/export_question_request.dart';
import 'package:test_maker_native_app/feature/workbook/api/export_workbook_response.dart';
import 'package:test_maker_native_app/feature/workbook/api/import_workbook_response.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final workbookConvertApiProvider = Provider.autoDispose<WorkbookConvertApi>(
  (ref) => WorkbookConvertApi(),
);

class WorkbookConvertApi {
  TaskEither<AppException, ImportWorkbookResponse> importWorkbook({
    required String workbookTitle,
    required String text,
  }) =>
      TaskEither.tryCatch(
        () async {
          final url = Uri.http(
            'us-central1-testmaker-1cb29.cloudfunctions.net',
            'textToTest',
          );

          final response = await http.post(
            url,
            body: {
              'title': workbookTitle,
              'text': text,
              'lang': 'ja',
            },
          );

          if (response.statusCode == 200) {
            return ImportWorkbookResponse.fromJson(
                json.decode(response.body) as Map<String, dynamic>);
          } else {
            throw const AppException(
              message: AppExceptionMessage.importWorkbookFailure,
            );
          }
        },
        (error, _) => AppException.fromRawException(e: error),
      );

  TaskEither<AppException, ExportWorkbookResponse> exportWorkbook({
    required Workbook workbook,
    required List<Question> questions,
  }) =>
      TaskEither.tryCatch(
        () async {
          final url = Uri.http(
            'us-central1-testmaker-1cb29.cloudfunctions.net',
            'testToText',
          );

          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'title': workbook.title,
              'questions': questions
                  .map((e) => ExportQuestionRequest.fromQuestion(e).toJson())
                  .toList(),
              'lang': 'ja',
            }),
          );

          if (response.statusCode == 200) {
            return ExportWorkbookResponse.fromJson(
                json.decode(response.body) as Map<String, dynamic>);
          } else {
            throw const AppException(
              message: AppExceptionMessage.exportWorkbookFailure,
            );
          }
        },
        (error, _) => AppException.fromRawException(e: error),
      );
}
