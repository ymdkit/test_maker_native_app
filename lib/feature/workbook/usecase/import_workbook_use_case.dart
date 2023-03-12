import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/workbook/api/import_question_response.dart';
import 'package:test_maker_native_app/feature/workbook/api/workbook_convert_api.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final importWorkbookUseCaseProvider =
    Provider.family.autoDispose<ImportWorkbookUseCase, AppDataLocation>(
  (ref, location) => ImportWorkbookUseCase(
    location: location,
    workbookConvertApi: ref.watch(workbookConvertApiProvider),
    workbookRepository: ref.watch(workbookRepositoryProvider(location)),
    questionRepository: ref.watch(questionRepositoryProvider(location)),
  ),
);

class ImportWorkbookUseCase {
  ImportWorkbookUseCase({
    required this.location,
    required this.workbookConvertApi,
    required this.workbookRepository,
    required this.questionRepository,
  });

  final AppDataLocation location;
  final WorkbookConvertApi workbookConvertApi;
  final WorkbookRepository workbookRepository;
  final QuestionRepository questionRepository;

  Future<Either<AppException, Workbook>> call({
    required String workbookTitle,
    required String text,
  }) =>
      workbookConvertApi
          .importWorkbook(workbookTitle: workbookTitle, text: text)
          .flatMap(
            (response) => workbookRepository
                .addWorkbook(
                  title: response.title,
                  color: AppThemeColor.blue,
                  folderId: null,
                  isPublic: false,
                )
                .flatMap(
                  (workbook) => TaskEither.right(
                    ImportWorkbookPayload(
                      workbook: workbook,
                      questions: response.questions,
                    ),
                  ),
                ),
          )
          .flatMap(
        (payload) {
          final questions = payload.questions
              .map(
                (e) => e.toQuestion(
                    workbookId: payload.workbook.workbookId,
                    location: location),
              )
              .toList();
          return questionRepository.addQuestions(questions).flatMap(
                (r) => TaskEither.right(
                  payload.workbook.copyWith(questionCount: questions.length),
                ),
              );
        },
      ).run();
}

class ImportWorkbookPayload {
  ImportWorkbookPayload({
    required this.workbook,
    required this.questions,
  });

  final Workbook workbook;
  final List<ImportQuestionResponse> questions;
}
