import 'dart:math';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/utils/app_image.dart';
import 'package:test_maker_native_app/widget/app_image_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

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
        Row(
          children: [
            AppSectionTitle(title: 'No.${question.displayIndex}'),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: LinearProgressIndicator(
                  value: question.displayIndex / max(question.totalCount, 1),
                  backgroundColor: Colors.grey,
                ),
              ),
            )
          ],
        ),
        Text(question.problem),
        Visibility(
          visible: question.problemImage != const AppImage.empty(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ClipRect(
                child: PhotoView.customChild(
                  childSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.3,
                  ),
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.transparent),
                  child: AppImageContent(
                    image: question.problemImage,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
