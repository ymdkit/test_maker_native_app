import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/group/repository/group_repository.dart';
import 'package:test_maker_native_app/feature/group/state/group_state.dart';
import 'package:test_maker_native_app/feature/group/state/group_workbooks_state.dart';
import 'package:test_maker_native_app/feature/group/state/groups_state.dart';
import 'package:test_maker_native_app/feature/group/ui/operate_group_workbook_sheet.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class GroupDetailsPage extends HookConsumerWidget {
  const GroupDetailsPage({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupProvider(groupId));
    final groupWorkbookState = ref.watch(groupWorkbooksStateProvider(groupId));

    return AppAdWrapper(
      adUnitId: AppAdUnitId.groupDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(group.title),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: _PopupMenuItems.invite,
                  child: Text('グループへの招待'),
                ),
                const PopupMenuItem(
                  value: _PopupMenuItems.edit,
                  child: Text('グループの編集'),
                ),
                if (group.isOwned)
                  const PopupMenuItem(
                    value: _PopupMenuItems.delete,
                    child: Text('グループの削除'),
                  )
                else
                  const PopupMenuItem(
                    value: _PopupMenuItems.delete,
                    child: Text('グループから退出'),
                  ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case _PopupMenuItems.invite:
                    final result = await ref
                        .read(groupRepositoryProvider)
                        .inviteGroup(group)
                        .run();
                    result.match(
                      (l) => showAppSnackBar(context, l.message),
                      (r) {
                        Clipboard.setData(ClipboardData(text: r));
                        showAppSnackBar(context, '招待リンクをコピーしました');
                      },
                    );
                    break;
                  case _PopupMenuItems.edit:
                    await context.router.push(
                      EditGroupRoute(group: group),
                    );
                    break;
                  case _PopupMenuItems.delete:
                    await showAlertDialog(
                      context: context,
                      title: 'グループの削除',
                      content: 'このグループを削除しますか？',
                      isDangerous: true,
                      positiveButtonText: '削除する',
                      onPositive: () async {
                        await showAlertDialog(
                          context: context,
                          title: 'グループの削除',
                          content: 'このグループを削除しますか？',
                          isDangerous: true,
                          positiveButtonText: '削除する',
                          onPositive: () async {
                            final result = await ref
                                .read(groupsProvider.notifier)
                                .deleteGroup(group);

                            result.match(
                              (l) => showAppSnackBar(context, l.message),
                              (success) {
                                showAppSnackBar(context, 'グループを削除しました');
                                context.router.pop();
                              },
                            );
                          },
                        );
                      },
                    );
                    break;
                  case _PopupMenuItems.exit:
                    await showAlertDialog(
                      context: context,
                      title: 'グループからの退出',
                      content: 'このグループから退出しますか？',
                      isDangerous: true,
                      positiveButtonText: '退出する',
                      onPositive: () async {
                        //TODO: グループから退出
                      },
                    );
                    break;
                }
              },
            ),
          ],
        ),
        body: groupWorkbookState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (e) => AppErrorContent.serverError(),
          success: (groupWorkbooks) => RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(groupWorkbooksStateProvider(groupId)),
            child: groupWorkbooks.isEmpty
                ? AppEmptyContent.groupWorkbook(
                    onPressedFallbackButton: () => context.router.push(
                      CreateGroupWorkbookRoute(groupId: groupId),
                    ),
                  )
                : ListView.builder(
                    itemCount: groupWorkbooks.length,
                    itemBuilder: (context, index) {
                      final groupWorkbook = groupWorkbooks[index];
                      return WorkbookListItem(
                        workbook: groupWorkbook,
                        onTap: (workbook) async =>
                            showOperateGroupWorkbookSheet(
                          context: context,
                          groupId: groupId,
                          workbook: workbook,
                        ),
                      );
                    },
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'groupDetailsPage',
          onPressed: () =>
              context.router.push(CreateGroupWorkbookRoute(groupId: groupId)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

enum _PopupMenuItems {
  invite,
  edit,
  delete,
  exit,
}
