import 'package:collection/collection.dart';
import 'package:test_maker_native_app/data/local/realm_schema.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/model/workbook.dart';

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
      problemImageUrl: question.problemImageUrl,
      answers: question.answers,
      wrongChoices: question.wrongChoices,
      explanation: question.explanation,
      explanationImageUrl: question.explanationImageUrl,
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
    );
  }
}
