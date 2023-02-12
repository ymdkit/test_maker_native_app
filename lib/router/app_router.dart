import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/main.dart';
import 'package:test_maker_native_app/ui/page/group/group_list_page.dart';
import 'package:test_maker_native_app/ui/page/home/home_page.dart';
import 'package:test_maker_native_app/ui/page/record/record_page.dart';
import 'package:test_maker_native_app/ui/page/search/search_workbook_page.dart';
import 'package:test_maker_native_app/ui/page/setting/setting_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: RootPage,
      initial: true,
      children: [
        AutoRoute(
          page: EmptyRouterPage,
          name: 'HomeTabRoute',
          initial: true,
          children: [
            AutoRoute(
              page: HomePage,
              initial: true,
            ),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'SearchTabRoute',
          children: [
            AutoRoute(page: SearchWorkbookPage),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'GroupTabRoute',
          children: [
            AutoRoute(page: GroupListPage),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'RecordTabRoute',
          children: [
            AutoRoute(page: RecordPage),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'SettingTabRoute',
          children: [
            AutoRoute(page: SettingPage),
          ],
        ),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}