import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/group/state/groups_state.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';

class GroupListPage extends HookConsumerWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountStateProvider);
    final groupsState = ref.watch(groupsProvider);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.groupListBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.tabGroup,
          ),
        ),
        body: accountState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          guest: () => AppEmptyContent.groupNotAuthorized(
              context: context,
              onPressedFallbackButton: () =>
                  context.router.push(const SignInRoute())),
          authenticated: (account) => groupsState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (e) => AppErrorContent.serverError(),
            success: (groups) => groups.isEmpty
                ? AppEmptyContent.group(
                    context: context,
                    onPressedFallbackButton: () {
                      context.router.push(const CreateGroupRoute());
                    },
                  )
                : RefreshIndicator(
                    onRefresh: () async => ref.refresh(groupsProvider),
                    child: ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        final group = groups[index];
                        return ListTile(
                          leading: Icon(
                            Icons.group,
                            color: group.color.displayColor(),
                          ),
                          title: Text(group.title),
                          subtitle: Text(
                              '''作成日 ${DateFormat(DateFormat.YEAR_NUM_MONTH_DAY).format(group.createdAt)}'''),
                          onTap: () => context.router.push(
                            GroupDetailsRoute(
                              groupId: group.groupId,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'groupListPage',
          onPressed: () => context.router.push(
            const CreateGroupRoute(),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
