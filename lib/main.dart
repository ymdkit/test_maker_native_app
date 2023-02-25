import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/setting/utils/shared_preference.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/theme/theme_ext.dart';
import 'package:test_maker_native_app/utils/package_information.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();

  await MobileAds.instance.initialize();
  await MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: [
        '85b923a71b0bd9a3a0d48f539907ae2f',
      ],
    ),
  );

  final packageInfo = await PackageInfo.fromPlatform();
  final preferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        packageInfoProvider.overrideWithValue(packageInfo),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: MyApp(
        initialLink: initialLink,
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({
    super.key,
    required this.initialLink,
  });

  final PendingDynamicLinkData? initialLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = useMemoized(() => AppRouter());
    final appThemeColor =
        ref.watch(preferencesStateProvider.select((value) => value.themeColor));

    useEffect(() {
      FirebaseDynamicLinks.instance.onLink.listen((event) async {
        await _handleDynamicLink(event, ref, context, appRouter);
      });
      () async {
        if (initialLink != null) {
          await _handleDynamicLink(initialLink!, ref, context, appRouter);
        }
      }();
      return null;
    }, const []);

    return MaterialApp.router(
      // TODO(ymdkit): Dynamic Links のハンドリング
      // TODO(ymdkit): ローカライズ
      locale: const Locale('ja', ''),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', ''),
      ],
      theme: ThemeData.light().copyWithSharedTheme(appThemeColor).copyWith(
            appBarTheme: const AppBarTheme(
              elevation: 0,
              foregroundColor: Colors.black87,
              backgroundColor: Colors.transparent,
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
      darkTheme: ThemeData.dark().copyWithSharedTheme(appThemeColor).copyWith(
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }

  Future<void> _handleDynamicLink(PendingDynamicLinkData event, WidgetRef ref,
      BuildContext context, AppRouter appRouter) async {
    final link = event.link.toString();
    final regex = RegExp(
        r'(?<=https://testmaker-1cb29\.com/).*|(?<=https://ankimaker\.com/).*');
    final match = regex.stringMatch(link);

    //TODO: グループ用の招待リンク受け取り

    if (match != null) {
      final workbookRepository =
          ref.read(workbookRepositoryProvider(AppDataLocation.remoteShared));
      final result = await workbookRepository.getWorkbook(workbookId: match);

      result.match(
        (l) => showAppSnackBar(context, l.message),
        (r) => appRouter.push(
          AnswerWorkbookRoute(workbook: r),
        ),
      );
    }
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
