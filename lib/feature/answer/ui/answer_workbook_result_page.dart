import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/ui/question_list_item.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';

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

    final wrongRate = answeringQuestions.isEmpty
        ? 0
        : answeringQuestions
                .where((q) => q.answerStatus == AnswerStatus.wrong)
                .length /
            answeringQuestions.length;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '正解数: ${answeringQuestions.where((q) => q.answerStatus == AnswerStatus.correct).length} / ${answeringQuestions.length}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: correctRate.toDouble(),
                          showTitle: false,
                          color: themeColor.displayColor(),
                          radius: 50,
                        ),
                        PieChartSectionData(
                          value: wrongRate.toDouble(),
                          showTitle: false,
                          color: Colors.grey,
                          radius: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return QuestionListItem(
                      question: answeringQuestions[index],
                      onTap: (workbook) {},
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
