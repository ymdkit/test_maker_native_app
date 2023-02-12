import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = useMemoized(() => AppRouter());

    return MaterialApp.router(
      // TODO(ymdkit): ダークテーマ対応
      // TODO(ymdkit): Dynamic Links のハンドリング
      // TODO(ymdkit): ローカライズ
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = useMemoized(
      () => [
        _BottomNavigationPageRoute(
          pageRouteInfo: const HomeTabRoute(),
          iconData: Icons.home,
          label: 'ホーム',
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const SearchTabRoute(),
          iconData: Icons.search,
          label: 'さがす',
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const GroupTabRoute(),
          iconData: Icons.group,
          label: 'グループ',
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const RecordTabRoute(),
          iconData: Icons.history,
          label: '学習記録',
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const SettingTabRoute(),
          iconData: Icons.settings,
          label: '設定',
        ),
      ],
    );

    return AutoTabsScaffold(
      routes: routes.map((e) => e.pageRouteInfo).toList(),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => tabsRouter.setActiveIndex(index),
          items: routes
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(e.iconData),
                  label: e.label,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _BottomNavigationPageRoute {
  final PageRouteInfo pageRouteInfo;
  final IconData iconData;
  final String label;

  _BottomNavigationPageRoute({
    required this.pageRouteInfo,
    required this.iconData,
    required this.label,
  });
}
