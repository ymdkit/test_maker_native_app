import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_explanation_section.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_problem_section.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class AnswerQuestionSelfScoreContent extends HookConsumerWidget {
  const AnswerQuestionSelfScoreContent({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiStateNotifier =
        ref.watch(answerWorkbookStateProvider(question.workbookId).notifier);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnswerProblemSection(
                    question: question,
                  ),
                  const AppSectionTitle(title: '解答'),
                  Text(
                    question.answers.join(' '),
                  ),
                  const SizedBox(height: 16),
                  AnswerExplanationSection(
                    question: question,
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      uiStateNotifier.updateAnswerStatus(question, true);
                      await uiStateNotifier.forward();
                    },
                    child: const Text('正解'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () async {
                      uiStateNotifier.updateAnswerStatus(question, false);
                      await uiStateNotifier.forward();
                    },
                    child: const Text('不正解'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
