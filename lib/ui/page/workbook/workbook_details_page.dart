import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/questions_state.dart';
import 'package:test_maker_native_app/state/workbook_state.dart';
import 'package:test_maker_native_app/ui/page/question/question_list_item.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';

class WorkbookDetailsPage extends HookConsumerWidget {
  const WorkbookDetailsPage({
    super.key,
    required this.workbookId,
  });

  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbook = ref.watch(workbookProvider(workbookId));
    final questions = ref.watch(questionsProvider(workbookId));

    return Scaffold(
      appBar: AppBar(
        title: Text(workbook.title),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) => QuestionListItem(
          question: questions[index],
          onTap: (question) => showAppSnackBar(context, question.problem),
        ),
      ),
    );
  }
}
