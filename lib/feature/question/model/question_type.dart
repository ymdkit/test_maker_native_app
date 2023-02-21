import 'package:collection/collection.dart';

enum QuestionType {
  write,
  select,
  complete,
  selectComplete;

  //TODO: ローカライズ
  String toDisplayString() {
    switch (this) {
      case QuestionType.write:
        return '記述';
      case QuestionType.select:
        return '選択';
      case QuestionType.complete:
        return '完答';
      case QuestionType.selectComplete:
        return '選択完答';
    }
  }

  static QuestionType from(int index) {
    return QuestionType.values.elementAtOrNull(index) ?? QuestionType.write;
  }

  bool hasMultipleAnswers() {
    switch (this) {
      case QuestionType.write:
        return false;
      case QuestionType.select:
        return false;
      case QuestionType.complete:
        return true;
      case QuestionType.selectComplete:
        return true;
    }
  }

  bool hasWrongChoices() {
    switch (this) {
      case QuestionType.write:
        return false;
      case QuestionType.select:
        return true;
      case QuestionType.complete:
        return false;
      case QuestionType.selectComplete:
        return true;
    }
  }
}
