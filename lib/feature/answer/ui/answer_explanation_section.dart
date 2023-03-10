import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/widget/app_image_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class AnswerExplanationSection extends StatelessWidget {
  const AnswerExplanationSection({
    super.key,
    required this.question,
  });

  final AnsweringQuestion question;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: question.explanation.isNotNullOrEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSectionTitle(
            title: AppLocalizations.of(context)!.sectionQuestionExplanation,
          ),
          Text(
            question.explanation ?? '',
          ),
          const SizedBox(height: 16),
          AppImageContent(image: question.explanationImage),
        ],
      ),
    );
  }
}
