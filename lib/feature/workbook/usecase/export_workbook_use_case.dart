import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/workbook/api/workbook_convert_api.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final exportWorkbookUseCaseProvider =
    Provider.autoDispose<ExportWorkbookUseCase>(
  (ref) => ExportWorkbookUseCase(
    workbookConvertApi: ref.watch(workbookConvertApiProvider),
  ),
);

class ExportWorkbookUseCase {
  ExportWorkbookUseCase({
    required this.workbookConvertApi,
  });

  final WorkbookConvertApi workbookConvertApi;

  Future<Either<AppException, String>> call({
    required Workbook workbook,
    required List<Question> questions,
  }) =>
      workbookConvertApi
          .exportWorkbook(
            workbook: workbook,
            questions: questions,
          )
          .flatMap(
            (r) => TaskEither.right(r.text),
          )
          .run();
}
