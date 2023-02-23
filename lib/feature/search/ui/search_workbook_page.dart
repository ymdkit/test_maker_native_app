import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/search/state/search_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

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
            autofocus: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: '検索',
              border: InputBorder.none,
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
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: AppSectionTitle(title: '検索結果'),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => WorkbookListItem(
                        workbook: workbooks[index],
                        onTap: (workbook) {},
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
