import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/state/folder_state.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';
import 'package:test_maker_native_app/ui/page/workbook/operate_workbook_sheet.dart';
import 'package:test_maker_native_app/ui/page/workbook/workbook_list_item.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';

class FolderDetailsPage extends HookConsumerWidget {
  const FolderDetailsPage({super.key, required this.folderId});

  final String folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(folderProvider(folderId));
    final workbooks = ref.watch(workbooksProvider(folderId));

    return AppAdWrapper(
      adUnitId: AppAdUnitId.folderDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(folder.title),
          actions: [
            IconButton(
              onPressed: () => context.router.push(
                EditFolderRoute(folder: folder),
              ),
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: workbooks.isEmpty
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
