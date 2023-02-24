import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
          title: const Text('グループ一覧'),
        ),
        body: accountState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          guest: () => AppEmptyContent.groupNotAuthorized(
              onPressedFallbackButton: () =>
                  context.router.push(const SignInRoute())),
          authenticated: (account) => groupsState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (e) => AppErrorContent.serverError(),
            success: (groups) => groups.isEmpty
                ? AppEmptyContent.group(onPressedFallbackButton: () {
                    context.router.push(const CreateGroupRoute());
                  })
                : ListView.builder(
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return ListTile(
                        leading: Icon(
                          Icons.group,
                          color: group.color.displayColor(),
                        ),
                        title: Text(group.title),
                        onTap: () => context.router.push(
                          const GroupDetailsRoute(),
                        ),
                      );
                    },
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.router.push(
            const CreateGroupRoute(),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
