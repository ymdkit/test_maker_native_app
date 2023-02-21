import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_folders_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_questions_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_sliver_section.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class TrashPage extends HookConsumerWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(deletedFoldersProvider);
    final workbooks = ref.watch(deletedWorkbooksProvider);
    final questions = ref.watch(deletedQuestionsProvider);

    final isContentNotEmpty =
        folders.isNotEmpty || workbooks.isNotEmpty || questions.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ゴミ箱'),
        actions: [
          if (isContentNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () => showAlertDialog(
                context: context,
                title: 'ゴミ箱を空にする',
                content: 'ゴミ箱内に含まれるデータを全て削除しますか？',
                isDangerous: true,
                onPositive: () {
                  ref
                      .read(deletedQuestionsProvider.notifier)
                      .destroyQuestions();
                  ref
                      .read(deletedWorkbooksProvider.notifier)
                      .destroyWorkbooks();
                  ref.read(deletedFoldersProvider.notifier).destroyFolders();
                  showAppSnackBar(context, '削除しました');
                },
              ),
            ),
        ],
      ),
      body: AppAdWrapper(
        adUnitId: AppAdUnitId.settingBanner,
        child: isContentNotEmpty
            ? CustomScrollView(
                slivers: [
                  SliverVisibility(
                    visible: folders.isNotEmpty,
                    sliver: AppSliverSection(
                      title: 'フォルダ',
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return WorkbookListItem(
                              workbook: workbooks[index],
                              onTap: (workbook) => showAlertDialog(
                                context: context,
                                title: 'フォルダの復元',
                                content:
                                    'フォルダ ${folders[index].title} を復元しますか？',
                                onPositive: () {
                                  ref
                                      .read(deletedFoldersProvider.notifier)
                                      .restoreFolder(folders[index]);
                                  showAppSnackBar(context, 'フォルダを復元しました');
                                },
                              ),
                            );
                          },
                          childCount: folders.length,
                        ),
                      ),
                    ),
                  ),
                  SliverVisibility(
                    visible: workbooks.isNotEmpty,
                    sliver: AppSliverSection(
                      title: '問題集',
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return WorkbookListItem(
                              workbook: workbooks[index],
                              onTap: (workbook) => showAlertDialog(
                                context: context,
                                title: '問題集の復元',
                                content:
                                    '問題集 ${workbooks[index].title} を復元しますか？',
                                onPositive: () {
                                  ref
                                      .read(deletedWorkbooksProvider.notifier)
                                      .restoreWorkbook(workbooks[index]);
                                  showAppSnackBar(context, '問題集を復元しました');
                                },
                              ),
                            );
                          },
                          childCount: workbooks.length,
                        ),
                      ),
                    ),
                  ),
                  SliverVisibility(
                    visible: questions.isNotEmpty,
                    sliver: AppSliverSection(
                      title: '問題',
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return WorkbookListItem(
                              workbook: workbooks[index],
                              onTap: (workbook) => showAlertDialog(
                                context: context,
                                title: '問題の復元',
                                content: 'この問題を復元しますか？',
                                onPositive: () {
                                  ref
                                      .read(deletedQuestionsProvider.notifier)
                                      .restoreQuestion(questions[index]);
                                  showAppSnackBar(context, '問題を復元しました');
                                },
                              ),
                            );
                          },
                          childCount: questions.length,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const AppEmptyContent.trash(),
      ),
    );
  }
}
