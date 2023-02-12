import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/question.dart';

class QuestionListItem extends StatelessWidget {
  const QuestionListItem({
    super.key,
    required this.question,
    required this.onTap,
  });

  final Question question;
  final void Function(Question) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(question.problem),
      subtitle: Text(question.answers.join(' ')),
      onTap: () => onTap(question),
    );
  }
}
