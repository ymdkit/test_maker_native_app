import 'package:collection/collection.dart';
import 'package:realm/realm.dart';
import 'package:test_maker_native_app/model/enum/answer_status.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/model/workbook.dart';

part 'realm_schema.g.dart';

@RealmModel()
@MapTo('Question')
class _RealmQuestion {
  @PrimaryKey()
  late String questionId;

  late String workbookId;
  late int questionType;
  late String problem;
  late String? problemImageUrl;
  late String answer;
  late List<String> answers;
  late List<String> wrongChoices;
  late String? explanation;
  late String? explanationImageUrl;
  late bool isAutoGenerateWrongChoices;
  late bool isCheckAnswerOrder;
  late int order;
  late String answerStatus;

  Question toQuestion() {
    return Question(
      questionId: questionId,
      workbookId: workbookId,
      questionType: QuestionType.from(questionType),
      problem: problem,
      problemImageUrl: problemImageUrl,
      answers: answers,
      wrongChoices: wrongChoices,
      explanation: explanation,
      explanationImageUrl: explanationImageUrl,
      isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
      isCheckAnswerOrder: isCheckAnswerOrder,
      order: order,
      answerStatus: AnswerStatus.values.firstWhereOrNull(
            (e) => e.toString() == answerStatus,
          ) ??
          AnswerStatus.unAnswered,
    );
  }
}

@RealmModel()
@MapTo('Test')
class _RealmWorkbook {
  @PrimaryKey()
  late String workbookId;

  late String title;
  late int order;
  late int color;
  late String? folderId;

  Workbook toWorkbook({
    required int questionCount,
  }) {
    return Workbook(
        workbookId: workbookId,
        title: title,
        order: order,
        color: ColorTheme.fromIndex(color),
        folderId: folderId,
        questionCount: questionCount);
  }
}

@RealmModel()
@MapTo('Category')
class _RealmFolder {
  @PrimaryKey()
  late String folderId;

  late String title;
  late int order;
  late int color;

  Folder toFolder({
    required int workbookCount,
  }) {
    return Folder(
      folderId: folderId,
      title: title,
      order: order,
      color: ColorTheme.fromIndex(color),
      workbookCount: workbookCount,
    );
  }
}
