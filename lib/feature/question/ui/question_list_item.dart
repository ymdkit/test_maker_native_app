import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';

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
      trailing: question.problemImageUrl != null &&
              File(question.problemImageUrl!).existsSync()
          ? Image.file(
              File(question.problemImageUrl!),
              fit: BoxFit.contain,
            )
          : null,
      onTap: () => onTap(question),
    );
  }
}
