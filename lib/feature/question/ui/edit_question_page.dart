import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/question/ui/edit_question_form.dart';

class EditQuestionPage extends HookConsumerWidget {
  const EditQuestionPage({
    super.key,
    required this.workbookId,
    required this.question,
    required this.location,
  });

  final String workbookId;
  final Question question;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EditQuestionForm.edit(
      workbookId: workbookId,
      question: question,
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
              problemImage: problemImage,
              answers: answers,
              wrongChoices: wrongChoices,
              explanation: explanation,
              explanationImage: explanationImage,
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
