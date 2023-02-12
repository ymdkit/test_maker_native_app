import 'package:realm/realm.dart';

part 'realm_schema.g.dart';

@RealmModel()
@MapTo('Question')
class _RealmQuestion {
  @PrimaryKey()
  late String questionId;

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
}

@RealmModel()
@MapTo('Test')
class _RealmWorkbook {
  @PrimaryKey()
  late String workbookId;

  late String title;
  late int order;
  late int color;

  late List<_RealmQuestion> questions;
}

@RealmModel()
@MapTo('Category')
class _RealmFolder {
  @PrimaryKey()
  late String folderId;

  late String title;
  late int order;
  late int color;

  late List<_RealmWorkbook> workbooks;
}
