import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';

class AnswerProblemSection extends StatelessWidget {
  const AnswerProblemSection({
    super.key,
    required this.question,
  });

  final AnsweringQuestion question;

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
