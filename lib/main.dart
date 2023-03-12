import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/group/state/groups_state.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/setting/utils/preference_migrator.dart';
import 'package:test_maker_native_app/feature/setting/utils/shared_preference.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/theme/theme_ext.dart';
import 'package:test_maker_native_app/utils/package_information.dart';

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
  await PreferenceMigrator.migrate(preferences);

  await Purchases.setLogLevel(LogLevel.error);
  await Purchases.configure(
    PurchasesConfiguration(
      Platform.isAndroid
          ? const String.fromEnvironment('revenueCatAndroidPublicApiKey')
          : const String.fromEnvironment('revenueCatIOSPublicApiKey'),
    ),
  );

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
      // TODO(ymdkit): ローカライズ
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
            listTileTheme: const ListTileThemeData(
              iconColor: Colors.grey,
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

    if (match != null) {
      final parameters = match.split('/');

      if (parameters.length == 2 && parameters[0] == 'groups') {
        final groupId = parameters[1];

        final result =
            await ref.read(groupsProvider.notifier).joinGroup(groupId);

        //TODO: 未ログインやグループが存在しない場合のエラー出し分け
        await result.match(
          (l) {},
          (r) => appRouter.push(
            const RootRoute(children: [
              GroupTabRoute(
                children: [
                  GroupListRoute(),
                ],
              ),
            ]),
          ),
        );
      } else {
        final workbookRepository =
            ref.read(workbookRepositoryProvider(AppDataLocation.remoteShared));
        final result = await workbookRepository.getWorkbook(workbookId: match);

        await result.match(
          (l) {},
          (r) => appRouter.push(
            AnswerWorkbookRoute(workbook: r),
          ),
        );
      }
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
          label: AppLocalizations.of(context)!.tabHome,
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const SearchTabRoute(),
          iconData: Icons.search,
          label: AppLocalizations.of(context)!.tabSearch,
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const GroupTabRoute(),
          iconData: Icons.group,
          label: AppLocalizations.of(context)!.tabGroup,
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const RecordTabRoute(),
          iconData: Icons.history,
          label: AppLocalizations.of(context)!.tabRecord,
        ),
        _BottomNavigationPageRoute(
          pageRouteInfo: const SettingTabRoute(),
          iconData: Icons.settings,
          label: AppLocalizations.of(context)!.tabSetting,
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
