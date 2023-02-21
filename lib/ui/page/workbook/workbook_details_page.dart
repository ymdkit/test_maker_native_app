import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/questions_state.dart';
import 'package:test_maker_native_app/state/workbook_state.dart';
import 'package:test_maker_native_app/ui/page/question/operate_question_sheet.dart';
import 'package:test_maker_native_app/ui/page/question/question_list_item.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';

class WorkbookDetailsPage extends HookConsumerWidget {
  const WorkbookDetailsPage({
    super.key,
    required this.folderId,
    required this.workbookId,
  });

  final String? folderId;
  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbook = ref.watch(
      workbookProvider(
        folderId: folderId,
        workbookId: workbookId,
      ),
    );
    final questions = ref.watch(questionsProvider(workbookId));

    return AppAdWrapper(
      adUnitId: AppAdUnitId.workbookDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(workbook.title),
          actions: [
            IconButton(
              onPressed: () => context.router.push(
                EditWorkbookRoute(workbook: workbook),
              ),
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: questions.isEmpty
            ? AppEmptyContent.question(
                onPressedFallbackButton: () => context.router.push(
                  CreateQuestionRoute(workbookId: workbook.workbookId),
                ),
              )
            : ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) => QuestionListItem(
                  question: questions[index],
                  onTap: (question) async => showOperateQuestionSheet(
                    context,
                    question,
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.router.push(
            CreateQuestionRoute(workbookId: workbook.workbookId),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
