import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/folders_state.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';
import 'package:test_maker_native_app/ui/page/folder/folder_list_item.dart';
import 'package:test_maker_native_app/ui/page/workbook/operate_workbook_sheet.dart';
import 'package:test_maker_native_app/ui/page/workbook/workbook_list_item.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/ui/widget/app_empty_content.dart';
import 'package:test_maker_native_app/ui/widget/app_sliver_section.dart';
import 'package:test_maker_native_app/ui/widget/app_sliver_space.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider);
    final workbooks = ref.watch(workbooksProvider(null));

    return AppAdWrapper(
      adUnitId: AppAdUnitId.homeBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('暗記メーカー'),
        ),
        body: folders.isEmpty && workbooks.isEmpty
            ? AppEmptyContent.workbook(
                onPressedFallbackButton: () => context.router.push(
                  CreateWorkbookRoute(folder: null),
                ),
              )
            : CustomScrollView(
                slivers: [
                  const AppSliverSpace(height: 16),
                  SliverVisibility(
                    visible: folders.isNotEmpty,
                    sliver: MultiSliver(
                      children: [
                        AppSliverSection(
                          title: 'フォルダ',
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return FolderListItem(
                                  folder: folders[index],
                                  onTap: (folder) => context.router.push(
                                    FolderDetailsRoute(
                                      folderId: folder.folderId,
                                    ),
                                  ),
                                );
                              },
                              childCount: folders.length,
                            ),
                          ),
                        ),
                        const AppSliverSpace(height: 16),
                      ],
                    ),
                  ),
                  SliverVisibility(
                    visible: folders.isNotEmpty && workbooks.isNotEmpty,
                    sliver: MultiSliver(
                      children: const [
                        SliverToBoxAdapter(
                            child: Divider(indent: 16, endIndent: 16)),
                        AppSliverSpace(height: 16),
                      ],
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
                              onTap: (workbook) async =>
                                  showOperateWorkbookSheet(context, workbook),
                            );
                          },
                          childCount: workbooks.length,
                        ),
                      ),
                    ),
                  )
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.router.push(
            CreateWorkbookRoute(folder: null),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
