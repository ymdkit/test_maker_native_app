import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/utils/app_image.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class DebugPage extends HookConsumerWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.watch(accountStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('デバッグページ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (account is AccountState_Authorized) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AppSectionTitle(title: 'ユーザ情報'),
              ),
              ListTile(
                title: const Text('ユーザID'),
                subtitle: Text(account.account.accountId),
              ),
              ListTile(
                title: const Text('ユーザ名'),
                subtitle: Text(account.account.name),
              ),
              ListTile(
                title: const Text('メールアドレス'),
                subtitle: Text(account.account.email),
              ),
            ],
            const Divider(indent: 16, endIndent: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: AppSectionTitle(title: 'ユーテリティ'),
            ),
            ListTile(
              title: const Text('テスト用問題集作成'),
              onTap: () async {
                final result = await ref
                    .read(workbooksProvider(const WorkbooksStateKey(
                      location: AppDataLocation.local,
                      folderId: null,
                    )).notifier)
                    .addWorkbook(
                        title: 'サンプル問題集',
                        color: AppThemeColor.blue,
                        folderId: null);

                result.match(
                  (l) => showAppSnackBar(context, l.message),
                  (newWorkbook) {
                    ref.read(questionsProvider(
                      QuestionsStateKey(
                        location: AppDataLocation.local,
                        workbookId: newWorkbook.workbookId,
                      ),
                    ).notifier)
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.write,
                        problem: '記述問題の問題文',
                        problemImage: const AppImage.empty(),
                        answers: ['記述問題の答え'],
                        wrongChoices: [],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: false,
                      )
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.write,
                        problem:
                            List.generate(20, (index) => '記述問題の問題文').join(),
                        problemImage: const AppImage.empty(),
                        answers: ['記述問題の答え'],
                        wrongChoices: [],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: false,
                      )
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.select,
                        problem: '選択問題の問題文',
                        problemImage: const AppImage.empty(),
                        answers: ['選択問題の答え'],
                        wrongChoices: ['選択問題の間違い1', '選択問題の間違い2'],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: false,
                      )
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.complete,
                        problem: '完答問題の問題文',
                        problemImage: const AppImage.empty(),
                        answers: ['完答問題の答え1', '完答問題の答え2'],
                        wrongChoices: [],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: false,
                      )
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.complete,
                        problem: '完答問題の問題文（順序チェックあり）',
                        problemImage: const AppImage.empty(),
                        answers: ['完答問題の答え1', '完答問題の答え2'],
                        wrongChoices: [],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: true,
                      )
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.selectComplete,
                        problem: '選択完答問題の問題文',
                        problemImage: const AppImage.empty(),
                        answers: ['選択完答問題の答え1', '選択完答問題の答え2'],
                        wrongChoices: ['選択完答問題の間違い1', '選択完答問題の間違い2'],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: false,
                      )
                      ..addQuestion(
                        workbookId: newWorkbook.workbookId,
                        questionType: QuestionType.selectComplete,
                        problem: '選択完答問題（順序チェックあり）の問題文',
                        problemImage: const AppImage.empty(),
                        answers: ['選択完答問題の答え1', '選択完答問題の答え2'],
                        wrongChoices: ['選択完答問題の間違い1', '選択完答問題の間違い2'],
                        explanation: '',
                        explanationImage: const AppImage.empty(),
                        isAutoGenerateWrongChoices: false,
                        isCheckAnswerOrder: true,
                      );
                    showAppSnackBar(context, '問題集を作成しました');
                  },
                );
              },
            ),
            ListTile(
              title: const Text('テストユーザログイン'),
              onTap: () async {
                final result = await ref
                    .read(accountStateProvider.notifier)
                    .signInWithEmailAndPassword(
                      email: 'test@example.com',
                      password: 'Abc123@a',
                    );

                result.match(
                  (l) => showAppSnackBar(context, l.message),
                  (r) => showAppSnackBar(context, 'ログインに成功しました'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
