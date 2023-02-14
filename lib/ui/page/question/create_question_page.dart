import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/questions_state.dart';
import 'package:test_maker_native_app/ui/page/question/edit_question_form.dart';

class CreateQuestionPage extends HookConsumerWidget {
  const CreateQuestionPage({
    super.key,
    required this.workbookId,
  });

  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditQuestionForm.create(
      workbookId: workbookId,
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
      }) {
        ref.read(questionsProvider(workbookId).notifier).addQuestion(
              workbookId: workbookId,
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
      },
    );
  }
}
