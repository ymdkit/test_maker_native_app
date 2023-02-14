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
      title: Text(
        question.problem,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(question.answers.join(' '),
          maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () => onTap(question),
    );
  }
}
