// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    HomeTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    SearchTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    GroupTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    RecordTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    SettingTabRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    FolderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<FolderDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: FolderDetailsPage(
          key: args.key,
          folderId: args.folderId,
        ),
      );
    },
    CreateWorkbookRoute.name: (routeData) {
      final args = routeData.argsAs<CreateWorkbookRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateWorkbookPage(
          key: args.key,
          folder: args.folder,
        ),
      );
    },
    CreateFolderRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateFolderPage(),
      );
    },
    WorkbookDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<WorkbookDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WorkbookDetailsPage(
          key: args.key,
          workbookId: args.workbookId,
        ),
      );
    },
    SearchWorkbookRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SearchWorkbookPage(),
      );
    },
    GroupListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const GroupListPage(),
      );
    },
    RecordRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const RecordPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SettingPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          RootRoute.name,
          path: '/',
          children: [
            RouteConfig(
              HomeTabRoute.name,
              path: '',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomeTabRoute.name,
                ),
                RouteConfig(
                  FolderDetailsRoute.name,
                  path: 'folder-details-page',
                  parent: HomeTabRoute.name,
                ),
                RouteConfig(
                  CreateWorkbookRoute.name,
                  path: 'create-workbook-page',
                  parent: HomeTabRoute.name,
                ),
                RouteConfig(
                  CreateFolderRoute.name,
                  path: 'create-folder-page',
                  parent: HomeTabRoute.name,
                ),
                RouteConfig(
                  WorkbookDetailsRoute.name,
                  path: 'workbook-details-page',
                  parent: HomeTabRoute.name,
                ),
              ],
            ),
            RouteConfig(
              SearchTabRoute.name,
              path: 'empty-router-page',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  SearchWorkbookRoute.name,
                  path: 'search-workbook-page',
                  parent: SearchTabRoute.name,
                )
              ],
            ),
            RouteConfig(
              GroupTabRoute.name,
              path: 'empty-router-page',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  GroupListRoute.name,
                  path: 'group-list-page',
                  parent: GroupTabRoute.name,
                )
              ],
            ),
            RouteConfig(
              RecordTabRoute.name,
              path: 'empty-router-page',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  RecordRoute.name,
                  path: 'record-page',
                  parent: RecordTabRoute.name,
                )
              ],
            ),
            RouteConfig(
              SettingTabRoute.name,
              path: 'empty-router-page',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  SettingRoute.name,
                  path: 'setting-page',
                  parent: SettingTabRoute.name,
                )
              ],
            ),
          ],
        )
      ];
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRoute';
}

/// generated route for
/// [EmptyRouterPage]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
      : super(
          HomeTabRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomeTabRoute';
}

/// generated route for
/// [EmptyRouterPage]
class SearchTabRoute extends PageRouteInfo<void> {
  const SearchTabRoute({List<PageRouteInfo>? children})
      : super(
          SearchTabRoute.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'SearchTabRoute';
}

/// generated route for
/// [EmptyRouterPage]
class GroupTabRoute extends PageRouteInfo<void> {
  const GroupTabRoute({List<PageRouteInfo>? children})
      : super(
          GroupTabRoute.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'GroupTabRoute';
}

/// generated route for
/// [EmptyRouterPage]
class RecordTabRoute extends PageRouteInfo<void> {
  const RecordTabRoute({List<PageRouteInfo>? children})
      : super(
          RecordTabRoute.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'RecordTabRoute';
}

/// generated route for
/// [EmptyRouterPage]
class SettingTabRoute extends PageRouteInfo<void> {
  const SettingTabRoute({List<PageRouteInfo>? children})
      : super(
          SettingTabRoute.name,
          path: 'empty-router-page',
          initialChildren: children,
        );

  static const String name = 'SettingTabRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [FolderDetailsPage]
class FolderDetailsRoute extends PageRouteInfo<FolderDetailsRouteArgs> {
  FolderDetailsRoute({
    Key? key,
    required String folderId,
  }) : super(
          FolderDetailsRoute.name,
          path: 'folder-details-page',
          args: FolderDetailsRouteArgs(
            key: key,
            folderId: folderId,
          ),
        );

  static const String name = 'FolderDetailsRoute';
}

class FolderDetailsRouteArgs {
  const FolderDetailsRouteArgs({
    this.key,
    required this.folderId,
  });

  final Key? key;

  final String folderId;

  @override
  String toString() {
    return 'FolderDetailsRouteArgs{key: $key, folderId: $folderId}';
  }
}

/// generated route for
/// [CreateWorkbookPage]
class CreateWorkbookRoute extends PageRouteInfo<CreateWorkbookRouteArgs> {
  CreateWorkbookRoute({
    Key? key,
    required Folder? folder,
  }) : super(
          CreateWorkbookRoute.name,
          path: 'create-workbook-page',
          args: CreateWorkbookRouteArgs(
            key: key,
            folder: folder,
          ),
        );

  static const String name = 'CreateWorkbookRoute';
}

class CreateWorkbookRouteArgs {
  const CreateWorkbookRouteArgs({
    this.key,
    required this.folder,
  });

  final Key? key;

  final Folder? folder;

  @override
  String toString() {
    return 'CreateWorkbookRouteArgs{key: $key, folder: $folder}';
  }
}

/// generated route for
/// [CreateFolderPage]
class CreateFolderRoute extends PageRouteInfo<void> {
  const CreateFolderRoute()
      : super(
          CreateFolderRoute.name,
          path: 'create-folder-page',
        );

  static const String name = 'CreateFolderRoute';
}

/// generated route for
/// [WorkbookDetailsPage]
class WorkbookDetailsRoute extends PageRouteInfo<WorkbookDetailsRouteArgs> {
  WorkbookDetailsRoute({
    Key? key,
    required String workbookId,
  }) : super(
          WorkbookDetailsRoute.name,
          path: 'workbook-details-page',
          args: WorkbookDetailsRouteArgs(
            key: key,
            workbookId: workbookId,
          ),
        );

  static const String name = 'WorkbookDetailsRoute';
}

class WorkbookDetailsRouteArgs {
  const WorkbookDetailsRouteArgs({
    this.key,
    required this.workbookId,
  });

  final Key? key;

  final String workbookId;

  @override
  String toString() {
    return 'WorkbookDetailsRouteArgs{key: $key, workbookId: $workbookId}';
  }
}

/// generated route for
/// [SearchWorkbookPage]
class SearchWorkbookRoute extends PageRouteInfo<void> {
  const SearchWorkbookRoute()
      : super(
          SearchWorkbookRoute.name,
          path: 'search-workbook-page',
        );

  static const String name = 'SearchWorkbookRoute';
}

/// generated route for
/// [GroupListPage]
class GroupListRoute extends PageRouteInfo<void> {
  const GroupListRoute()
      : super(
          GroupListRoute.name,
          path: 'group-list-page',
        );

  static const String name = 'GroupListRoute';
}

/// generated route for
/// [RecordPage]
class RecordRoute extends PageRouteInfo<void> {
  const RecordRoute()
      : super(
          RecordRoute.name,
          path: 'record-page',
        );

  static const String name = 'RecordRoute';
}

/// generated route for
/// [SettingPage]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute()
      : super(
          SettingRoute.name,
          path: 'setting-page',
        );

  static const String name = 'SettingRoute';
}
