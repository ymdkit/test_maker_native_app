import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/ui/folder_list_item.dart';
import 'package:test_maker_native_app/feature/group/state/group_workbooks_state.dart';
import 'package:test_maker_native_app/feature/home/state/home_ui_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_sliver_section.dart';
import 'package:test_maker_native_app/widget/app_sliver_space.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class CreateGroupWorkbookPage extends HookConsumerWidget {
  const CreateGroupWorkbookPage({
    super.key,
    required this.groupId,
  });

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(homeUiStateProvider);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.groupDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('登録する問題集を選択'),
        ),
        body: uiState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          empty: () => AppEmptyContent.workbook(
            context: context,
            onPressedFallbackButton: () => context.router.push(
              CreateWorkbookRoute(
                folder: null,
                location: AppDataLocation.remoteOwned,
              ),
            ),
          ),
          success: (folders, workbooks) => RefreshIndicator(
            onRefresh: () async => ref.refresh(
              workbooksProvider(
                const WorkbooksStateKey(
                  location: AppDataLocation.remoteOwned,
                  folderId: null,
                ),
              ),
            ),
            child: CustomScrollView(
              slivers: [
                const AppSliverSpace(height: 16),
                SliverVisibility(
                  visible: folders.isNotEmpty,
                  sliver: MultiSliver(
                    children: [
                      AppSliverSection(
                        title: AppLocalizations.of(context)!.folder,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return FolderListItem(
                                folder: folders[index],
                                onTap: (folder) => context.router.push(
                                  CreateGroupWorkbookInFolderRoute(
                                    folderId: folder.folderId,
                                    groupId: groupId,
                                    location: folder.location,
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
                    title: AppLocalizations.of(context)!.workbook,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return WorkbookListItem(
                              workbook: workbooks[index],
                              onTap: (workbook) async {
                                final result = await ref
                                    .read(groupWorkbooksStateProvider(groupId)
                                        .notifier)
                                    .addWorkbookToGroup(workbook: workbook);

                                result.match(
                                  (l) => showAppSnackBar(context, l.message),
                                  (r) {
                                    showAppSnackBar(context, '問題集を登録しました');
                                    context.router.pop();
                                  },
                                );
                              });
                        },
                        childCount: workbooks.length,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          failure: (_) => AppErrorContent.serverError(),
        ),
      ),
    );
  }
}
