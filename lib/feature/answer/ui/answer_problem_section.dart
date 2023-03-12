import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/record/model/correct_answer_rate_calculator.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/utils/app_image.dart';
import 'package:test_maker_native_app/widget/app_image_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class AnswerProblemSection extends HookConsumerWidget {
  const AnswerProblemSection({
    super.key,
    required this.question,
  });

  final AnsweringQuestion question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor =
        ref.watch(preferencesStateProvider.select((e) => e.themeColor));
    final usecase = ref.watch(calculateAnswerRateUseCaseProvider);

    final answerRate = useMemoized(() => usecase.call(
          questionId: question.questionId,
        ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppSectionTitle(
              title: AppLocalizations.of(context)!
                  .sectionQuestionIndex(question.displayIndex),
            ),
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
        ),
        Visibility(
          visible: question.rawQuestion.answerStatus != AnswerStatus.unAnswered,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '''正答率 ${(answerRate * 100).toStringAsFixed(2)}%''',
                style: TextStyle(
                  color: answerRate > 0.5
                      ? themeColor.displayColor()
                      : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
