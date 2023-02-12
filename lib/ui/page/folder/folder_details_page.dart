import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/folder_state.dart';
import 'package:test_maker_native_app/ui/page/workbook/workbook_list_item.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';

class FolderDetailsPage extends HookConsumerWidget {
  const FolderDetailsPage({super.key, required this.folderId});

  final String folderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(folderProvider(folderId));

    return Scaffold(
      appBar: AppBar(
        title: Text(folder.title),
      ),
      body: folder.workbooks.isEmpty
          ? AppEmptyContent.workbook(
              // TODO(ymdkit): 問題集作成画面への遷移
              onPressedFallbackButton: () => showAppSnackBar(
                context,
                '問題集を作成する',
              ),
            )
          : ListView.builder(
              itemCount: folder.workbooks.length,
              itemBuilder: (context, index) => WorkbookListItem(
                workbook: folder.workbooks[index],
                onTap: (workbook) => context.router.push(
                  WorkbookDetailsRoute(workbookId: workbook.workbookId),
                ),
              ),
            ),
    );
  }
}
