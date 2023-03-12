import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/search/state/search_workbooks_state.dart';
import 'package:test_maker_native_app/feature/search/ui/operate_search_workbook_sheet.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_sliver_space.dart';

class SearchWorkbookPage extends HookConsumerWidget {
  const SearchWorkbookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbooks = ref.watch(searchWorkbooksProvider);
    final queryController = useTextEditingController();

    return AppAdWrapper(
      adUnitId: AppAdUnitId.searchBanner,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 8,
          title: TextField(
            controller: queryController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: '検索',
              border: InputBorder.none,
              suffix: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  queryController.clear();
                  ref.read(searchWorkbooksQueryProvider.notifier).state = '';
                },
              ),
            ),
            onSubmitted: (query) {
              ref.read(searchWorkbooksQueryProvider.notifier).state = query;
            },
          ),
        ),
        body: workbooks.when(
          data: (workbooks) {
            if (workbooks.isEmpty) {
              return const AppEmptyContent.search();
            }
            return RefreshIndicator(
              onRefresh: () async {
                ref.read(searchWorkbooksQueryProvider.notifier).state =
                    queryController.text;
              },
              child: CustomScrollView(
                slivers: [
                  const AppSliverSpace(height: 16),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: AppSectionTitle(
                        title:
                            AppLocalizations.of(context)!.sectionSearchResult,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => WorkbookListItem(
                        workbook: workbooks[index],
                        onTap: (workbook) async =>
                            showOperateSearchedWorkbookSheet(
                          context,
                          workbook,
                        ),
                      ),
                      childCount: workbooks.length,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => AppErrorContent.serverError(),
        ),
      ),
    );
  }
}
