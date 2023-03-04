import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/record/state/answer_histories_state.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';

class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerHistories = ref.watch(answerHistoriesProvider);
    return AppAdWrapper(
      adUnitId: AppAdUnitId.recordBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('学習記録'),
        ),
        body: answerHistories.when(
          data: (answerHistories) => RefreshIndicator(
            onRefresh: () async => ref.refresh(answerHistoriesProvider),
            child: ListView.builder(
              itemCount: answerHistories.length,
              itemBuilder: (context, index) {
                final answerHistory = answerHistories[index];
                return ListTile(
                  title: Text(answerHistory.questionId),
                  subtitle: Text(answerHistory.answerHistoryId),
                  trailing: Text(answerHistory.isCorrect ? '正解' : '不正解'),
                );
              },
            ),
          ),
          error: (error, stackTrace) => Center(
            child: AppErrorContent.serverError(),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
