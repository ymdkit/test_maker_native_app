import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/ui/widget/app_section_title.dart';

class AnswerExplanationSection extends StatelessWidget {
  const AnswerExplanationSection({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: question.explanation.isNotNullOrEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppSectionTitle(title: '解説'),
          Text(
            question.explanation ?? '',
          ),
          if (question.explanationImageUrl != null &&
              File(question.explanationImageUrl!).existsSync()) ...[
            const SizedBox(height: 16),
            Image.file(
              File(question.explanationImageUrl!),
              fit: BoxFit.contain,
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}