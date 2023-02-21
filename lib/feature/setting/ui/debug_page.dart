import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class DebugPage extends HookConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグページ'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: const Text('テスト用問題集作成'),
            onTap: () {
              final newWorkbook = ref
                  .read(workbooksProvider(null).notifier)
                  .addWorkbook(
                      title: 'サンプル問題集',
                      color: AppThemeColor.blue,
                      folderId: null);

              ref.read(questionsProvider(newWorkbook.workbookId).notifier)
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.write,
                  problem: '記述問題の問題文',
                  problemImageUrl: null,
                  answers: ['記述問題の答え'],
                  wrongChoices: [],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                )
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.write,
                  problem: '記述問題の問題文',
                  problemImageUrl: null,
                  answers: ['記述問題の答え'],
                  wrongChoices: [],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                )
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.select,
                  problem: '選択問題の問題文',
                  problemImageUrl: null,
                  answers: ['選択問題の答え'],
                  wrongChoices: ['選択問題の間違い1', '選択問題の間違い2'],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                )
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.complete,
                  problem: '完答問題の問題文',
                  problemImageUrl: null,
                  answers: ['完答問題の答え1', '完答問題の答え2'],
                  wrongChoices: [],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                )
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.complete,
                  problem: '完答問題の問題文',
                  problemImageUrl: null,
                  answers: ['完答問題の答え1', '完答問題の答え2'],
                  wrongChoices: [],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                )
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.selectComplete,
                  problem: '選択完答問題の問題文',
                  problemImageUrl: null,
                  answers: ['選択完答問題の答え1', '選択完答問題の答え2'],
                  wrongChoices: ['選択完答問題の間違い1', '選択完答問題の間違い2'],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                )
                ..addQuestion(
                  workbookId: newWorkbook.workbookId,
                  questionType: QuestionType.selectComplete,
                  problem: '選択完答問題の問題文',
                  problemImageUrl: null,
                  answers: ['選択完答問題の答え1', '選択完答問題の答え2'],
                  wrongChoices: ['選択完答問題の間違い1', '選択完答問題の間違い2'],
                  explanation: '',
                  explanationImageUrl: null,
                  isAutoGenerateWrongChoices: false,
                  isCheckAnswerOrder: false,
                );
              showAppSnackBar(context, '問題集を作成しました');
            },
          ),
        ],
      )),
    );
  }
}
