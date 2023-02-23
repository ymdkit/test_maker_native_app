import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_effect_widget.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_question_form_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_question_review_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_qustion_confirm_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_workbook_result_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_workbook_self_score_content.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbook_state.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';

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
    final state = ref.watch(answerWorkbookStateProvider(workbookId));

    return WillPopScope(
      onWillPop: () async {
        return state.maybeWhen(
          finished: (_) => true,
          orElse: () async {
            await _showConfirmFinishAlertDialog(context, ref, workbook);
            return false;
          },
        );
      },
      child: Focus(
        focusNode: screenFocusNode,
        child: GestureDetector(
          onTap: screenFocusNode.requestFocus,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(workbook.title),
              actions: [
                state.maybeWhen(
                  finished: (_) => const SizedBox.shrink(),
                  orElse: () => TextButton(
                    onPressed: () =>
                        _showConfirmFinishAlertDialog(context, ref, workbook),
                    child: const Text('中断'),
                  ),
                )
              ],
            ),
            body: AppAdWrapper(
              adUnitId: AppAdUnitId.answerWorkbookBanner,
              child: Stack(
                children: [
                  state.maybeWhen(
                    empty: () => AppEmptyContent.question(
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
                    ),
                    answering: (question) =>
                        AnswerQuestionFormContent(question: question),
                    reviewing: (question, attemptAnswers) =>
                        AnswerQuestionReviewContent(
                      question: question,
                      attemptAnswers: attemptAnswers,
                    ),
                    confirming: (question) =>
                        AnswerQuestionConfirmContent(question: question),
                    selfScoring: (question) =>
                        AnswerQuestionSelfScoreContent(question: question),
                    finished: (questions) => AnswerWorkbookResultContent(
                        workbook: workbook, answeringQuestions: questions),
                    orElse: () => const SizedBox.shrink(),
                  ),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: AnswerEffectWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmFinishAlertDialog(
    BuildContext context,
    WidgetRef ref,
    Workbook workbook,
  ) {
    return showAlertDialog(
      context: context,
      title: '解答の中断',
      content: '現在の解答を中断し、ホーム画面に戻りますか？',
      onPositive: () => context.router.popUntilRoot(),
    );
  }
}
