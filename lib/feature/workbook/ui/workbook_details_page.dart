import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/ui/operate_question_sheet.dart';
import 'package:test_maker_native_app/feature/question/ui/question_list_item.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbook_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class WorkbookDetailsPage extends HookConsumerWidget {
  const WorkbookDetailsPage({
    super.key,
    required this.folderId,
    required this.workbookId,
    required this.location,
  });

  final String? folderId;
  final String workbookId;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbook = ref.watch(
      workbookProvider(
        key: WorkbooksStateKey(
          location: location,
          folderId: folderId,
        ),
        workbookId: workbookId,
      ),
    );
    final questionsState = ref.watch(questionsProvider(workbookId));

    return AppAdWrapper(
      adUnitId: AppAdUnitId.workbookDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          //TODO: 編集後に戻ってきた場合に、タイトルが更新されてないので修正する
          title: Text(workbook.title),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: _PopupMenuItems.edit,
                  child: Text('問題集の編集'),
                ),
                const PopupMenuItem(
                  value: _PopupMenuItems.delete,
                  child: Text('問題集の削除'),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case _PopupMenuItems.edit:
                    context.router.push(
                      EditWorkbookRoute(workbook: workbook),
                    );
                    break;
                  case _PopupMenuItems.delete:
                    showAlertDialog(
                      context: context,
                      title: '問題集の削除',
                      content: 'この問題集を削除しますか？',
                      isDangerous: true,
                      positiveButtonText: '削除する',
                      onPositive: () async {
                        final result = await ref
                            .read(
                              workbooksProvider(
                                      WorkbooksStateKey.from(workbook))
                                  .notifier,
                            )
                            .deleteWorkbook(workbook);

                        result.match(
                          (l) => showAppSnackBar(
                            context,
                            l.message,
                          ),
                          (success) {
                            showAppSnackBar(context, '問題集をゴミ箱に移動しました');
                            context.router.pop();
                          },
                        );
                      },
                    );
                    break;
                }
              },
            ),
          ],
        ),
        body: questionsState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          success: (questions) => questions.isEmpty
              ? AppEmptyContent.question(
                  onPressedFallbackButton: () => context.router.push(
                    CreateQuestionRoute(workbookId: workbook.workbookId),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: AppSectionTitle(title: '問題一覧'),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => QuestionListItem(
                          question: questions[index],
                          onTap: (question) async => showOperateQuestionSheet(
                            context,
                            question,
                          ),
                        ),
                        childCount: questions.length,
                      ),
                    ),
                  ],
                ),
          failure: (e) => AppErrorContent.serverError(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.router.push(
            CreateQuestionRoute(workbookId: workbook.workbookId),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

enum _PopupMenuItems {
  edit,
  delete,
}
