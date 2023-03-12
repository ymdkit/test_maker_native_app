import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum QuestionCondition {
  all,
  onlyWrong,
  onlyUnAnswered,
  wrongAndUnAnswered,
  weekPoints;

  String displayString(BuildContext context) {
    switch (this) {
      case QuestionCondition.all:
        return AppLocalizations.of(context)!.questionConditionAll;
      case QuestionCondition.onlyWrong:
        return AppLocalizations.of(context)!.questionConditionOnlyWrong;
      case QuestionCondition.onlyUnAnswered:
        return AppLocalizations.of(context)!.questionConditionOnlyUnAnswered;
      case QuestionCondition.wrongAndUnAnswered:
        return AppLocalizations.of(context)!
            .questionConditionOnlyUnAnsweredAndWrong;
      case QuestionCondition.weekPoints:
        return AppLocalizations.of(context)!.questionConditionWeekPoints;
    }
  }
}
