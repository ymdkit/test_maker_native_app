import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/ui/page/workbook/workbook_list_item.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_sliver_section.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';

class TrashPage extends HookConsumerWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbooks = ref.watch(deletedWorkbooksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ゴミ箱'),
      ),
      body: AppAdWrapper(
        adUnitId: AppAdUnitId.settingBanner,
        child: CustomScrollView(
          slivers: [
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
          ],
        ),
      ),
    );
  }
}
