import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/answering_questions_state.dart';
import 'package:test_maker_native_app/state/workbook_state.dart';
import 'package:test_maker_native_app/ui/page/question/answer_question_form.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';

class AnswerWorkbookPage extends HookConsumerWidget {
  const AnswerWorkbookPage({
    super.key,
    required this.folderId,
    required this.workbookId,
  });

  final String? folderId;
  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenFocusNode = useFocusNode();

    final workbook = ref.watch(
      workbookProvider(
        folderId: folderId,
        workbookId: workbookId,
      ),
    );
    final questions = ref.watch(answeringQuestionsProvider(workbookId));
    final index = useState(0);
    final isLoading = useState(true);

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
          body: AppAdWrapper(
            adUnitId: AppAdUnitId.answerWorkbookBanner,
            child: questions.isEmpty
                ? AppEmptyContent.question(
                    onPressedFallbackButton: () => context.router.replaceAll(
                      [
                        const HomeRoute(),
                        WorkbookDetailsRoute(
                          folderId: folderId,
                          workbookId: workbookId,
                        ),
                        CreateQuestionRoute(workbookId: workbookId),
                      ],
                    ),
                  )
                : isLoading.value
                    ? AnswerQuestionForm(
                        question: questions[index.value],
                        onAnswered: () async {
                          if (index.value < questions.length - 1) {
                            //NOTE: AnswerQuestionForm を表示したままだと前問解答時の状態が残るため、
                            //一旦 AnswerQuestionForm を破棄してから再表示する
                            isLoading.value = false;
                            await Future<void>.delayed(
                                const Duration(milliseconds: 10));
                            isLoading.value = true;
                            index.value++;
                          } else {
                            await context.router.push(
                              AnswerWorkbookResultRoute(workbook: workbook),
                            );
                          }
                        },
                      )
                    : const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}
