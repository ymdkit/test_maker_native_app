import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';

Future<T?> showOperateSearchedWorkbookSheet<T>(
  BuildContext context,
  Workbook workbook,
) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _OperateSearchedWorkbookSheet(
        workbook: workbook,
      ),
    );

class _OperateSearchedWorkbookSheet extends HookConsumerWidget {
  const _OperateSearchedWorkbookSheet({
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppDraggableScrollableSheet(
      initialChildSize: 0.4,
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                workbook.title,
                maxLines: 1,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('解答する'),
              onTap: () => context.router.push(
                AnswerWorkbookRoute(workbook: workbook),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('通報する'),
              onTap: () async {
                //TODO: 通報機能を実装する
              },
            ),
          ],
        ),
      ),
    );
  }
}
