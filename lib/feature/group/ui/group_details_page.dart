import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/group/state/group_state.dart';
import 'package:test_maker_native_app/feature/group/state/group_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';

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
        ),
        body: groupWorkbookState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => AppErrorContent.serverError(),
          data: (groupWorkbooks) => RefreshIndicator(
            onRefresh: () async =>
                ref.refresh(groupWorkbooksStateProvider(groupId)),
            child: groupWorkbooks.isEmpty
                ? AppEmptyContent.workbook(onPressedFallbackButton: () {
                    //TODO: 問題集作成
                  })
                : ListView.builder(
                    itemCount: groupWorkbooks.length,
                    itemBuilder: (context, index) {
                      final groupWorkbook = groupWorkbooks[index];
                      return WorkbookListItem(
                        workbook: groupWorkbook,
                        onTap: (workbook) {
                          // TODO 問題集解答
                        },
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
