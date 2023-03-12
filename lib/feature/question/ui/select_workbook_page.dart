import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/ui/folder_list_item.dart';
import 'package:test_maker_native_app/feature/question/state/select_workbook_ui_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
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

class SelectWorkbookPage extends HookConsumerWidget {
  const SelectWorkbookPage({
    super.key,
    required this.title,
    required this.location,
    required this.onSelected,
    this.folderId,
  });

  final String title;
  final AppDataLocation location;
  final String? folderId;
  final void Function(Workbook) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(
      selectWorkbookUiStateProvider(
        WorkbooksStateKey(
          location: location,
          folderId: folderId,
        ),
      ),
    );

    return AppAdWrapper(
      adUnitId: AppAdUnitId.groupDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
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
                                  SelectWorkbookRoute(
                                    location: location,
                                    folderId: folder.folderId,
                                    title: title,
                                    onSelected: onSelected,
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
                            onTap: (workbook) {
                              onSelected(workbook);
                              context.router.popUntil(
                                (route) =>
                                    route.settings.name ==
                                    WorkbookDetailsRoute.name,
                              );
                            },
                          );
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
