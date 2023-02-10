import 'package:realm/realm.dart';

part 'realm_question.g.dart';

@RealmModel()
class _RealmQuestion {
  late String questionId;
  late int questionType;
  late String problem;
  String? problemImageUrl;
  late List<String> answers;
  late List<String> wrongChoices;
  String? explanation;
  String? explanationImageUrl;
  late bool isAutoGenerateWrongChoices;
  late bool isCheckAnswerOrder;
  late int order;
  late int answerStatus = 0;
}
