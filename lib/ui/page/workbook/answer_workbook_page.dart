import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/questions_state.dart';
import 'package:test_maker_native_app/state/workbook_state.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';

class AnswerWorkbookPage extends HookConsumerWidget {
  const AnswerWorkbookPage({super.key, required this.workbookId});

  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbook = ref.watch(workbookProvider(workbookId));
    final questions = ref.watch(questionsProvider(workbookId));
    final index = useState(0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(workbook.title),
        actions: [
          TextButton(
            onPressed: () {
              showAlertDialog(
                context: context,
                title: '解答の終了',
                content: '解答を終了しますか？',
                onPositive: () => context.router.push(
                  AnswerWorkbookResultRoute(workbook: workbook),
                ),
              );
            },
            child: const Text('終了'),
          ),
        ],
      ),
      body: questions.isEmpty
          ? AppEmptyContent.question(
              onPressedFallbackButton: () => context.router.replaceAll(
                [
                  const HomeRoute(),
                  WorkbookDetailsRoute(workbookId: workbookId),
                  CreateQuestionRoute(workbookId: workbookId),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(questions[index.value].problem),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: ElevatedButton(
                    onPressed: () {
                      if (index.value < questions.length - 1) {
                        index.value++;
                      } else {
                        context.router.push(
                          AnswerWorkbookResultRoute(workbook: workbook),
                        );
                      }
                    },
                    child: const Text('OK'),
                  ),
                )
              ],
            ),
    );
  }
}
