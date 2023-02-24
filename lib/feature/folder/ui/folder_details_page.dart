import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/state/folder_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/ui/operate_workbook_sheet.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class FolderDetailsPage extends HookConsumerWidget {
  const FolderDetailsPage({super.key, required this.folderId});

  final String folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(folderProvider(folderId));
    final workbooks = ref.watch(localWorkbooksProvider(folderId));

    return AppAdWrapper(
      adUnitId: AppAdUnitId.folderDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(folder.title),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: _PopupMenuItems.edit,
                  child: Text('フォルダの編集'),
                ),
                const PopupMenuItem(
                  value: _PopupMenuItems.delete,
                  child: Text('フォルダの削除'),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case _PopupMenuItems.edit:
                    context.router.push(
                      EditFolderRoute(folder: folder),
                    );
                    break;
                  case _PopupMenuItems.delete:
                    showAlertDialog(
                      context: context,
                      title: 'フォルダの削除',
                      content: 'このフォルダを削除しますか？',
                      isDangerous: true,
                      positiveButtonText: '削除する',
                      onPositive: () async {
                        final result = await ref
                            .read(foldersProvider.notifier)
                            .deleteFolder(folder);

                        result.match(
                          (l) => showAppSnackBar(context, l.message),
                          (r) {
                            showAppSnackBar(context, 'フォルダをゴミ箱に移動しました');
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
        body: workbooks.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (workbooks) => workbooks.isEmpty
              ? AppEmptyContent.workbook(
                  onPressedFallbackButton: () => context.router.push(
                    CreateWorkbookRoute(folder: folder),
                  ),
                )
              : ListView.builder(
                  itemCount: workbooks.length,
                  itemBuilder: (context, index) => WorkbookListItem(
                    workbook: workbooks[index],
                    onTap: (workbook) async =>
                        showOperateWorkbookSheet(context, workbook),
                  ),
                ),
          failure: (_) => AppErrorContent.serverError(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.router.push(
            CreateWorkbookRoute(folder: folder),
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
