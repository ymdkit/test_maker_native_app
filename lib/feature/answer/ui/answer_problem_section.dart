import 'package:flutter/material.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/widget/app_image_content.dart';

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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: AppImageContent(image: question.problemImage),
        )
      ],
    );
  }
}
