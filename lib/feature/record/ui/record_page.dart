import 'package:collection/collection.dart';
import 'package:dartx/dartx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_maker_native_app/constants/magic_number.dart';
import 'package:test_maker_native_app/feature/record/state/answer_histories_state.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_sliver_space.dart';

class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerHistories = ref.watch(answerHistoriesProvider);
    return AppAdWrapper(
      adUnitId: AppAdUnitId.recordBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.tabRecord,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => ref.refresh(answerHistoriesProvider),
          child: CustomScrollView(
            slivers: [
              const AppSliverSpace(height: 16),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(
                          enabled: false,
                        ),
                        titlesData: FlTitlesData(
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitles,
                              reservedSize: 36,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        gridData: FlGridData(
                          show: false,
                        ),
                        barGroups: List.generate(
                            MagicNumber.showRecordDateCount, (index) {
                          final date = DateTime.now()
                              .subtract(
                                Duration(
                                  days: MagicNumber.showRecordDateCount -
                                      1 -
                                      index,
                                ),
                              )
                              .date;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: answerHistories
                                        .firstWhereOrNull((element) =>
                                            element.date.eqvYearMonthDay(date))
                                        ?.incorrectCount
                                        .toDouble() ??
                                    0,
                                color: Colors.grey,
                              ),
                              BarChartRodData(
                                toY: answerHistories
                                        .firstWhereOrNull((element) =>
                                            element.date.eqvYearMonthDay(date))
                                        ?.correctCount
                                        .toDouble() ??
                                    0,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              const AppSliverSpace(height: 16),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final answerHistory = answerHistories[index];
                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(
                        AppLocalizations.of(context)!.valueAnswerHistory(
                          answerHistory.correctCount,
                          answerHistory.totalCount,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat(DateFormat.YEAR_NUM_MONTH_DAY)
                            .format(answerHistory.date),
                      ),
                    );
                  },
                  childCount: answerHistories.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const limit = MagicNumber.showRecordDateCount;
    final titles = List.generate(
      limit,
      (index) => DateFormat('MM/dd').format(
        DateTime.now().subtract(
          Duration(days: limit - 1 - index),
        ),
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: Text(
        titles[value.toInt()],
      ),
    );
  }
}
