import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/question/ui/edit_question_form.dart';

class EditQuestionPage extends HookConsumerWidget {
  const EditQuestionPage({
    super.key,
    required this.workbookId,
    required this.question,
  });

  final String workbookId;
  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditQuestionForm.edit(
      workbookId: workbookId,
      question: question,
      onSubmit: ({
        required workbookId,
        required questionType,
        required problem,
        required problemImageUrl,
        required answers,
        required wrongChoices,
        required explanation,
        required explanationImageUrl,
        required isAutoGenerateWrongChoices,
        required isCheckAnswerOrder,
      }) async {
        await ref
            .read(questionsProvider(
              QuestionsStateKey(
                location: question.location,
                workbookId: question.workbookId,
              ),
            ).notifier)
            .updateQuestion(
              currentQuestion: question,
              questionType: questionType,
              problem: problem,
              problemImageUrl: problemImageUrl,
              answers: answers,
              wrongChoices: wrongChoices,
              explanation: explanation,
              explanationImageUrl: explanationImageUrl,
              isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
              isCheckAnswerOrder: isCheckAnswerOrder,
            );
        await Future.delayed(const Duration(milliseconds: 500), () {
          context.router.pop();
        });
      },
    );
  }
}
