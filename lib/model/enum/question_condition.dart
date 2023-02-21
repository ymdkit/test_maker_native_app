enum QuestionCondition {
  all,
  onlyWrong,
  onlyUnAnswered,
  wrongAndUnAnswered,
  weekPoints;

  // TODO(ymdkit): ローカライズ
  String displayString() {
    switch (this) {
      case QuestionCondition.all:
        return '全て';
      case QuestionCondition.onlyWrong:
        return '不正解のみ';
      case QuestionCondition.onlyUnAnswered:
        return '未出題のみ';
      case QuestionCondition.wrongAndUnAnswered:
        return '不正解 + 未出題';
      case QuestionCondition.weekPoints:
        return 'ニガテ問題のみ';
    }
  }
}
