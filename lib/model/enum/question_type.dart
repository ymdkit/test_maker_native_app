import 'package:collection/collection.dart';

enum QuestionType {
  write,
  select,
  complete,
  selectComplete;

  static QuestionType from(int index) {
    return QuestionType.values.elementAtOrNull(index) ?? QuestionType.write;
  }
}
