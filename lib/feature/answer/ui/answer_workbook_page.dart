import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_effect_widget.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_question_confirm_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_question_form_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_question_review_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_workbook_result_content.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_workbook_self_score_content.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';

class AnswerWorkbookPage extends HookConsumerWidget {
  const AnswerWorkbookPage({
    super.key,
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenFocusNode = useFocusNode();
    final state = ref.watch(answerWorkbookStateProvider(
      QuestionsStateKey(
        location: workbook.location,
        workbookId: workbook.workbookId,
      ),
    ));

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
                    child: Text(
                      AppLocalizations.of(context)!.buttonFinishAnswering,
                    ),
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
                      context: context,
                      onPressedFallbackButton: () => context.router.replaceAll(
                        [
                          const HomeRoute(),
                          WorkbookDetailsRoute(
                            folderId: workbook.folderId,
                            workbookId: workbook.workbookId,
                            location: workbook.location,
                          ),
                          CreateQuestionRoute(
                            location: workbook.location,
                            workbookId: workbook.workbookId,
                          ),
                        ],
                      ),
                    ),
                    answering: (question) => AnswerQuestionFormContent(
                      question: question,
                    ),
                    reviewing: (question, attemptAnswers) =>
                        AnswerQuestionReviewContent(
                      workbook: workbook,
                      question: question,
                      attemptAnswers: attemptAnswers,
                    ),
                    confirming: (question) =>
                        AnswerQuestionConfirmContent(question: question),
                    selfScoring: (question) => AnswerQuestionSelfScoreContent(
                        workbook: workbook, question: question),
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
      title: '解答の終了',
      content: AppLocalizations.of(context)!.confirmFinishAnswer,
      onPositive: () => ref
          .read(answerWorkbookStateProvider(
            QuestionsStateKey(
              location: workbook.location,
              workbookId: workbook.workbookId,
            ),
          ).notifier)
          .finish(),
    );
  }
}
