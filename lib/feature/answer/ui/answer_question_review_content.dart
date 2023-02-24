import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_explanation_section.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_problem_section.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class AnswerQuestionReviewContent extends HookConsumerWidget {
  const AnswerQuestionReviewContent({
    super.key,
    required this.workbook,
    required this.question,
    required this.attemptAnswers,
  });

  final Workbook workbook;
  final Question question;
  final List<String> attemptAnswers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
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
                  Visibility(
                    visible: attemptAnswers.any((e) => e.isNotEmpty),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AppSectionTitle(title: 'あなたの解答'),
                        Text(
                          attemptAnswers.join('\n'),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const AppSectionTitle(title: '解答'),
                  Text(
                    question.answers.join('\n'),
                  ),
                  const SizedBox(height: 16),
                  AnswerExplanationSection(
                    question: question,
                  ),
                  Visibility(
                    visible: workbook.isOwned,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => context.router.push(
                          EditQuestionRoute(
                            workbookId: question.workbookId,
                            question: question,
                          ),
                        ),
                        icon: const Icon(
                          Icons.edit,
                        ),
                        label: const Text('問題内容を修正する'),
                      ),
                    ),
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
              child: ElevatedButton(
                onPressed: () => notifier.forward(),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
