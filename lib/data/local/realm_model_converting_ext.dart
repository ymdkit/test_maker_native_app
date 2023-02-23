import 'package:collection/collection.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

extension RealmQuestionConverting on RealmQuestion {
  static RealmQuestion fromQuestion(Question question) {
    return RealmQuestion(
      question.questionId,
      question.workbookId,
      question.questionType.index,
      question.problem,
      question.answers.firstOrNull ?? '',
      question.isAutoGenerateWrongChoices,
      question.isCheckAnswerOrder,
      question.order,
      question.answerStatus.value,
      question.createdAt,
      question.updatedAt,
      problemImageUrl: question.problemImageUrl,
      answers: question.answers,
      wrongChoices: question.wrongChoices,
      explanation: question.explanation,
      explanationImageUrl: question.explanationImageUrl,
      lastAnsweredAt: question.lastAnsweredAt,
    );
  }
}

extension RealmWorkbookConverting on RealmWorkbook {
  static RealmWorkbook fromWorkbook(Workbook workbook) {
    return RealmWorkbook(
      workbook.workbookId,
      workbook.title,
      workbook.order,
      workbook.color.index,
      workbook.createdAt,
      workbook.updatedAt,
      folderId: workbook.folderId,
    );
  }
}

extension RealmFolderConverting on RealmFolder {
  static RealmFolder fromFolder(Folder folder) {
    return RealmFolder(
      folder.folderId,
      folder.title,
      folder.order,
      folder.color.index,
      folder.createdAt,
      folder.updatedAt,
    );
  }
}
