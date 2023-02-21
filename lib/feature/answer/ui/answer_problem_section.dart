import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';

class AnswerProblemSection extends StatelessWidget {
  const AnswerProblemSection({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(question.problem),
        const SizedBox(height: 16),
        if (question.problemImageUrl != null &&
            File(question.problemImageUrl!).existsSync())
          Column(
            children: [
              Image.file(
                File(question.problemImageUrl!),
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
            ],
          ),
      ],
    );
  }
}
