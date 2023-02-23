import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/ui/question_list_item.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class AnswerWorkbookResultContent extends HookConsumerWidget {
  const AnswerWorkbookResultContent({
    super.key,
    required this.workbook,
    required this.answeringQuestions,
  });

  final Workbook workbook;
  final List<Question> answeringQuestions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(
      preferencesStateProvider.select((value) => value.themeColor),
    );

    final correctRate = answeringQuestions.isEmpty
        ? 0
        : answeringQuestions
                .where((q) => q.answerStatus == AnswerStatus.correct)
                .length /
            answeringQuestions.length;

    final wrongRate = 1 - correctRate;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppSectionTitle(title: '解答結果'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            Visibility(
                              visible: correctRate > 0,
                              child: Expanded(
                                flex: (correctRate * 100).toInt(),
                                child: ColoredBox(
                                  color: themeColor.displayColor(),
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: wrongRate > 0,
                              child: Expanded(
                                flex: (wrongRate * 100).toInt(),
                                child: const ColoredBox(
                                  color: Colors.grey,
                                  child: SizedBox.expand(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '解答数',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: '${answeringQuestions.length}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const WidgetSpan(
                                        child: SizedBox(width: 16)),
                                    TextSpan(
                                      text: '正答数',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: '${answeringQuestions.where(
                                            (q) =>
                                                q.answerStatus ==
                                                AnswerStatus.correct,
                                          ).length}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const WidgetSpan(
                                        child: SizedBox(width: 16)),
                                    TextSpan(
                                      text: '正答率',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: '${(correctRate * 100).toInt()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                    child: Divider(),
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: AppSectionTitle(title: '問題'),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return QuestionListItem(
                      question: answeringQuestions[index],
                      onTap: (question) => context.router.push(
                        EditQuestionRoute(
                            workbookId: question.workbookId,
                            question: question),
                      ),
                    );
                  },
                  childCount: answeringQuestions.length,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const Divider(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => ref
                        .read(answerWorkbookStateProvider(workbook.workbookId)
                            .notifier)
                        .reset(),
                    child: const Text('もう一度解き直す'),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      context.router.replaceAll(
                        [const RootRoute()],
                      );
                    },
                    child: const Text('ホームに戻る'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
