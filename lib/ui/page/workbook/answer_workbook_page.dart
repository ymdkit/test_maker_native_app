import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/questions_state.dart';
import 'package:test_maker_native_app/state/workbook_state.dart';
import 'package:test_maker_native_app/ui/page/question/answer_question_content.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';

class AnswerWorkbookPage extends HookConsumerWidget {
  const AnswerWorkbookPage({super.key, required this.workbookId});

  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenFocusNode = useFocusNode();

    final workbook = ref.watch(workbookProvider(workbookId));
    final questions = ref.watch(questionsProvider(workbookId));
    final index = useState(0);

    return Focus(
      focusNode: screenFocusNode,
      child: GestureDetector(
        onTap: screenFocusNode.requestFocus,
        child: Scaffold(
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
              : AnswerQuestionContent(
                  question: questions[index.value],
                  onAnswered: () {
                    if (index.value < questions.length - 1) {
                      index.value++;
                    } else {
                      context.router.push(
                        AnswerWorkbookResultRoute(workbook: workbook),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}
