enum AnswerStatus {
  unAnswered('unanswered'),
  correct('correct'),
  wrong('wrong');

  final String value;

  const AnswerStatus(this.value);
}
