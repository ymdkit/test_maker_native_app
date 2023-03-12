import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum QuestionType {
  write,
  select,
  complete,
  selectComplete;

  String toDisplayString(BuildContext context) {
    switch (this) {
      case QuestionType.write:
        return AppLocalizations.of(context)!.questionTypeWrite;
      case QuestionType.select:
        return AppLocalizations.of(context)!.questionTypeSelect;
      case QuestionType.complete:
        return AppLocalizations.of(context)!.questionTypeComplete;
      case QuestionType.selectComplete:
        return AppLocalizations.of(context)!.questionTypeSelectComplete;
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
