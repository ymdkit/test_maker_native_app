import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_problem_section.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';

class AnswerQuestionConfirmContent extends HookConsumerWidget {
  const AnswerQuestionConfirmContent({
    super.key,
    required this.question,
  });

  final AnsweringQuestion question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(answerWorkbookStateProvider(QuestionsStateKey(
      location: question.rawQuestion.location,
      workbookId: question.rawQuestion.workbookId,
    )).notifier);
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
                onPressed: () => notifier.selfScore(),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
