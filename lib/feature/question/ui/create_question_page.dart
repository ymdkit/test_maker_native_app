import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/question/ui/edit_question_form.dart';

class CreateQuestionPage extends HookConsumerWidget {
  const CreateQuestionPage({
    super.key,
    required this.workbookId,
    required this.location,
  });

  final String workbookId;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditQuestionForm.create(
      workbookId: workbookId,
      location: location,
      onSubmit: ({
        required workbookId,
        required questionType,
        required problem,
        required problemImage,
        required answers,
        required wrongChoices,
        required explanation,
        required explanationImage,
        required isAutoGenerateWrongChoices,
        required isCheckAnswerOrder,
      }) {
        ref
            .read(questionsProvider(
              QuestionsStateKey(
                location: location,
                workbookId: workbookId,
              ),
            ).notifier)
            .addQuestion(
              workbookId: workbookId,
              questionType: questionType,
              problem: problem,
              problemImage: problemImage,
              answers: answers,
              wrongChoices: wrongChoices,
              explanation: explanation,
              explanationImage: explanationImage,
              isAutoGenerateWrongChoices: isAutoGenerateWrongChoices,
              isCheckAnswerOrder: isCheckAnswerOrder,
            );
      },
    );
  }
}
