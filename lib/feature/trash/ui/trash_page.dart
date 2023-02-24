import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/ui/folder_list_item.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_folders_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_questions_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/feature/trash/ui/trash_ui_state.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_sliver_section.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class TrashPage extends HookConsumerWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trashUiState = ref.watch(trashUiStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ゴミ箱'),
        actions: [
          trashUiState.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            success: (folders, workbooks, questions) => IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () => showAlertDialog(
                context: context,
                title: 'ゴミ箱を空にする',
                content: 'ゴミ箱内に含まれるデータを全て削除しますか？',
                isDangerous: true,
                onPositive: () async {
                  //TODO リファクタする
                  await ref
                      .read(deletedQuestionsProvider.notifier)
                      .destroyQuestions();
                  await ref
                      .read(deletedWorkbooksProvider(AppDataLocation.local)
                          .notifier)
                      .destroyWorkbooks();
                  await ref
                      .read(
                          deletedWorkbooksProvider(AppDataLocation.remoteOwned)
                              .notifier)
                      .destroyWorkbooks();
                  await ref
                      .read(deletedFoldersProvider(AppDataLocation.local)
                          .notifier)
                      .destroyFolders();
                  await ref
                      .read(deletedFoldersProvider(AppDataLocation.remoteOwned)
                          .notifier)
                      .destroyFolders();

                  // ignore: use_build_context_synchronously
                  showAppSnackBar(context, '削除しました');
                },
              ),
            ),
          ),
        ],
      ),
      body: AppAdWrapper(
        adUnitId: AppAdUnitId.settingBanner,
        child: trashUiState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          empty: () => const AppEmptyContent.trash(),
          success: (folders, workbooks, questions) => CustomScrollView(
            slivers: [
              SliverVisibility(
                visible: folders.isNotEmpty,
                sliver: AppSliverSection(
                  title: 'フォルダ',
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return FolderListItem(
                          folder: folders[index],
                          onTap: (workbook) => showAlertDialog(
                            context: context,
                            title: 'フォルダの復元',
                            content: 'フォルダ ${folders[index].title} を復元しますか？',
                            onPositive: () {
                              ref
                                  .read(deletedFoldersProvider(
                                          folders[index].location)
                                      .notifier)
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
                            content: '問題集 ${workbooks[index].title} を復元しますか？',
                            onPositive: () {
                              ref
                                  .read(deletedWorkbooksProvider(
                                          workbooks[index].location)
                                      .notifier)
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
          ),
          failure: (e) => AppErrorContent.serverError(),
        ),
      ),
    );
  }
}
