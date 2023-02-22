import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/state/answering_questions_state.dart';
import 'package:test_maker_native_app/feature/question/ui/question_list_item.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class AnswerWorkbookResultPage extends HookConsumerWidget {
  const AnswerWorkbookResultPage({
    super.key,
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answeringQuestions = ref.watch(
      answeringQuestionsProvider(workbook.workbookId),
    );

    return AppAdWrapper(
      adUnitId: AppAdUnitId.answerResultWorkbookBanner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(workbook.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final question = answeringQuestions[index];
                  return QuestionListItem(
                    question: question,
                    //TODO: 問題編集への動線を作る
                    onTap: (question) =>
                        showAppSnackBar(context, question.problem),
                  );
                },
                itemCount: answeringQuestions.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //TODO: 問題を解き直す
                      context.router.replaceAll(
                        [const RootRoute()],
                      );
                    },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
