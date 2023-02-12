import 'package:realm/realm.dart';

part 'realm_question.g.dart';

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
