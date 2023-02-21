import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/state/answering_questions_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_effect_widget.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_question_form.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_explanation_section.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_problem_section.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';
import 'package:test_maker_native_app/ui/widget/app_section_title.dart';

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
    final state = ref.watch(answerWorkbookStateProvider(workbookId));

    ref.listen(answerWorkbookStateProvider(workbookId), (_, next) {
      if (next == const AnswerWorkbookState.finished()) {
        context.router.push(
          AnswerWorkbookResultRoute(workbook: workbook),
        );
      }
    });

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
                : Stack(
                    children: [
                      state.maybeWhen(
                        answering: (question) => AnswerQuestionForm(
                          question: question,
                        ),
                        reviewing: (question) =>
                            _AnswerReviewContent(question: question),
                        confirming: (question) =>
                            _AnswerConfirmSection(question: question),
                        selfScoring: (question) =>
                            _AnswerSelfScoreContent(question: question),
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
    );
  }
}

class _AnswerConfirmSection extends HookConsumerWidget {
  const _AnswerConfirmSection({
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.watch(answerWorkbookStateProvider(question.workbookId).notifier);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnswerProblemSection(
                    question: question,
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => notifier.selfScore(),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnswerReviewContent extends HookConsumerWidget {
  const _AnswerReviewContent({
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.watch(answerWorkbookStateProvider(question.workbookId).notifier);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnswerProblemSection(
                    question: question,
                  ),
                  const AppSectionTitle(title: '解答'),
                  Text(
                    question.answers.join(' '),
                  ),
                  const SizedBox(height: 16),
                  AnswerExplanationSection(
                    question: question,
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () => notifier.forward(),
                child: const Text('OK'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnswerSelfScoreContent extends HookConsumerWidget {
  const _AnswerSelfScoreContent({
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier =
        ref.watch(answerWorkbookStateProvider(question.workbookId).notifier);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnswerProblemSection(
                    question: question,
                  ),
                  const AppSectionTitle(title: '解答'),
                  Text(
                    question.answers.join(' '),
                  ),
                  const SizedBox(height: 16),
                  AnswerExplanationSection(
                    question: question,
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            const Divider(height: 1),
            //TODO: 解答状況の永続化
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => notifier.forward(),
                    child: const Text('正解'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => notifier.forward(),
                    child: const Text('不正解'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
