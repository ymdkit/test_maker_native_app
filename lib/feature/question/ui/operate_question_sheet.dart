import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_modal_bottom_sheet.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';

Future<T?> showOperateQuestionSheet<T>(
  BuildContext context,
  Question question,
) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _OperateWorkbookSheet(
        question: question,
      ),
    );

class _OperateWorkbookSheet extends HookConsumerWidget {
  const _OperateWorkbookSheet({
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppDraggableScrollableSheet(
      initialChildSize: 0.4,
      maxChildSize: 0.4,
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(question.problem),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('編集する'),
              onTap: () {
                context.router.push(
                  EditQuestionRoute(
                    workbookId: question.workbookId,
                    question: question,
                  ),
                );
                context.router.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('削除する'),
              onTap: () {
                showAlertDialog(
                  context: context,
                  title: '問題の削除',
                  content: 'この問題を削除してもよろしいですか？',
                  positiveButtonText: '削除する',
                  isDangerous: true,
                  onPositive: () {
                    context.router.pop();
                    ref
                        .read(questionsProvider(question.workbookId).notifier)
                        .deleteQuestion(question);
                    showAppSnackBar(context, '問題をゴミ箱に移動しました');
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
