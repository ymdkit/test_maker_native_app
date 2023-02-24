import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

Group documentToGroup(
  String userId,
  DocumentSnapshot document,
) {
  final data = document.data() as Map<String, dynamic>?;
  if (data != null) {
    return Group(
      groupId: document.id,
      title: data['name'] as String,
      color: AppThemeColor.fromIndex(data.getOrElse('color', () => 0) as int),
      ownerId: data['userId'] as String,
      isOwned: data['userId'] == userId,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  } else {
    return Group.empty();
  }
}

Workbook documentToWorkbook(
  String userId,
  DocumentSnapshot document,
) {
  final data = document.data() as Map<String, dynamic>?;
  if (data != null) {
    return Workbook(
      workbookId: document.id,
      title: data['name'] as String,
      order: data['order'] as int,
      color: AppThemeColor.fromIndex(data.getOrElse('color', () => 0) as int),
      folderId: null,
      questionCount: data['size'] as int,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isOwned: data['userId'] == userId,
    );
  } else {
    return Workbook.empty();
  }
}

Question documentToQuestion(
  String workbookId,
  DocumentSnapshot document,
) {
  final data = document.data() as Map<String, dynamic>?;
  if (data != null) {
    return Question.from(
      questionId: document.id,
      workbookId: workbookId,
      questionType: QuestionType.values[data.getOrElse('type', () => 0) as int],
      problem: data['question'] as String,
      problemImageUrl: data['imageRef'] as String?,
      answers: (data['answers'] as List<dynamic>).isNotEmpty
          ? List.from(data['answers'] as List<dynamic>)
          : [data['answer'] as String],
      wrongChoices: List.from(data['others'] as List<dynamic>),
      explanation: data['explanation'] as String?,
      explanationImageUrl: data['explanationImageRef'] as String?,
      isAutoGenerateWrongChoices: data['auto'] as bool,
      isCheckAnswerOrder: data['checkOrder'] as bool,
      order: data['order'] as int,
      answerStatus: AnswerStatus.unAnswered,
      //TODO: リモートで管理できるようにする
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastAnsweredAt: null,
    );
  } else {
    return Question.empty();
  }
}
