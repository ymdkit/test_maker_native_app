import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/group/state/group_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

Future<T?> showOperateGroupWorkbookSheet<T>({
  required BuildContext context,
  required String groupId,
  required Workbook workbook,
}) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _OperateSearchedWorkbookSheet(
        groupId: groupId,
        workbook: workbook,
      ),
    );

class _OperateSearchedWorkbookSheet extends HookConsumerWidget {
  const _OperateSearchedWorkbookSheet({
    required this.groupId,
    required this.workbook,
  });

  final String groupId;
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
            Visibility(
              visible: workbook.isOwned,
              child: ListTile(
                leading: const Icon(Icons.report),
                title: const Text('グループから削除する'),
                onTap: () async {
                  await showAlertDialog(
                      context: context,
                      title: 'グループから削除',
                      content: '問題集をグループから削除しますか？',
                      isDangerous: true,
                      positiveButtonText: '削除する',
                      onPositive: () async {
                        final result = await ref
                            .read(
                              groupWorkbooksStateProvider(groupId).notifier,
                            )
                            .removeWorkbookFromGroup(
                              workbook: workbook,
                            );

                        result.match(
                          (l) => showAppSnackBar(context, l.message),
                          (r) => showAppSnackBar(context, '問題集をグループから削除しました'),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
