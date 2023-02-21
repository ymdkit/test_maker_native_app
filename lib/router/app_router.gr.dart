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
    AnswerWorkbookRoute.name: (routeData) {
      final args = routeData.argsAs<AnswerWorkbookRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AnswerWorkbookPage(
          key: args.key,
          folderId: args.folderId,
          workbookId: args.workbookId,
        ),
        fullscreenDialog: true,
      );
    },
    AnswerWorkbookResultRoute.name: (routeData) {
      final args = routeData.argsAs<AnswerWorkbookResultRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AnswerWorkbookResultPage(
          key: args.key,
          workbook: args.workbook,
        ),
        fullscreenDialog: true,
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
    EditFolderRoute.name: (routeData) {
      final args = routeData.argsAs<EditFolderRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditFolderPage(
          key: args.key,
          folder: args.folder,
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
          folderId: args.folderId,
          workbookId: args.workbookId,
        ),
      );
    },
    EditWorkbookRoute.name: (routeData) {
      final args = routeData.argsAs<EditWorkbookRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditWorkbookPage(
          key: args.key,
          workbook: args.workbook,
        ),
      );
    },
    CreateQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<CreateQuestionRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateQuestionPage(
          key: args.key,
          workbookId: args.workbookId,
        ),
      );
    },
    EditQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<EditQuestionRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditQuestionPage(
          key: args.key,
          workbookId: args.workbookId,
          question: args.question,
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
    GroupDetailsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const GroupDetailsPage(),
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
    DebugRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DebugPage(),
      );
    },
    TrashRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TrashPage(),
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
                  EditFolderRoute.name,
                  path: 'edit-folder-page',
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
                RouteConfig(
                  EditWorkbookRoute.name,
                  path: 'edit-workbook-page',
                  parent: HomeTabRoute.name,
                ),
                RouteConfig(
                  CreateQuestionRoute.name,
                  path: 'create-question-page',
                  parent: HomeTabRoute.name,
                ),
                RouteConfig(
                  EditQuestionRoute.name,
                  path: 'edit-question-page',
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
                  path: '',
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
                  path: '',
                  parent: GroupTabRoute.name,
                ),
                RouteConfig(
                  GroupDetailsRoute.name,
                  path: 'group-details-page',
                  parent: GroupTabRoute.name,
                ),
              ],
            ),
            RouteConfig(
              RecordTabRoute.name,
              path: 'empty-router-page',
              parent: RootRoute.name,
              children: [
                RouteConfig(
                  RecordRoute.name,
                  path: '',
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
                  path: '',
                  parent: SettingTabRoute.name,
                ),
                RouteConfig(
                  DebugRoute.name,
                  path: 'debug-page',
                  parent: SettingTabRoute.name,
                ),
                RouteConfig(
                  TrashRoute.name,
                  path: 'trash-page',
                  parent: SettingTabRoute.name,
                ),
              ],
            ),
          ],
        ),
        RouteConfig(
          AnswerWorkbookRoute.name,
          path: '/answer-workbook-page',
        ),
        RouteConfig(
          AnswerWorkbookResultRoute.name,
          path: '/answer-workbook-result-page',
        ),
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
/// [AnswerWorkbookPage]
class AnswerWorkbookRoute extends PageRouteInfo<AnswerWorkbookRouteArgs> {
  AnswerWorkbookRoute({
    Key? key,
    required String? folderId,
    required String workbookId,
  }) : super(
          AnswerWorkbookRoute.name,
          path: '/answer-workbook-page',
          args: AnswerWorkbookRouteArgs(
            key: key,
            folderId: folderId,
            workbookId: workbookId,
          ),
        );

  static const String name = 'AnswerWorkbookRoute';
}

class AnswerWorkbookRouteArgs {
  const AnswerWorkbookRouteArgs({
    this.key,
    required this.folderId,
    required this.workbookId,
  });

  final Key? key;

  final String? folderId;

  final String workbookId;

  @override
  String toString() {
    return 'AnswerWorkbookRouteArgs{key: $key, folderId: $folderId, workbookId: $workbookId}';
  }
}

/// generated route for
/// [AnswerWorkbookResultPage]
class AnswerWorkbookResultRoute
    extends PageRouteInfo<AnswerWorkbookResultRouteArgs> {
  AnswerWorkbookResultRoute({
    Key? key,
    required Workbook workbook,
  }) : super(
          AnswerWorkbookResultRoute.name,
          path: '/answer-workbook-result-page',
          args: AnswerWorkbookResultRouteArgs(
            key: key,
            workbook: workbook,
          ),
        );

  static const String name = 'AnswerWorkbookResultRoute';
}

class AnswerWorkbookResultRouteArgs {
  const AnswerWorkbookResultRouteArgs({
    this.key,
    required this.workbook,
  });

  final Key? key;

  final Workbook workbook;

  @override
  String toString() {
    return 'AnswerWorkbookResultRouteArgs{key: $key, workbook: $workbook}';
  }
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
/// [EditFolderPage]
class EditFolderRoute extends PageRouteInfo<EditFolderRouteArgs> {
  EditFolderRoute({
    Key? key,
    required Folder folder,
  }) : super(
          EditFolderRoute.name,
          path: 'edit-folder-page',
          args: EditFolderRouteArgs(
            key: key,
            folder: folder,
          ),
        );

  static const String name = 'EditFolderRoute';
}

class EditFolderRouteArgs {
  const EditFolderRouteArgs({
    this.key,
    required this.folder,
  });

  final Key? key;

  final Folder folder;

  @override
  String toString() {
    return 'EditFolderRouteArgs{key: $key, folder: $folder}';
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
    required String? folderId,
    required String workbookId,
  }) : super(
          WorkbookDetailsRoute.name,
          path: 'workbook-details-page',
          args: WorkbookDetailsRouteArgs(
            key: key,
            folderId: folderId,
            workbookId: workbookId,
          ),
        );

  static const String name = 'WorkbookDetailsRoute';
}

class WorkbookDetailsRouteArgs {
  const WorkbookDetailsRouteArgs({
    this.key,
    required this.folderId,
    required this.workbookId,
  });

  final Key? key;

  final String? folderId;

  final String workbookId;

  @override
  String toString() {
    return 'WorkbookDetailsRouteArgs{key: $key, folderId: $folderId, workbookId: $workbookId}';
  }
}

/// generated route for
/// [EditWorkbookPage]
class EditWorkbookRoute extends PageRouteInfo<EditWorkbookRouteArgs> {
  EditWorkbookRoute({
    Key? key,
    required Workbook workbook,
  }) : super(
          EditWorkbookRoute.name,
          path: 'edit-workbook-page',
          args: EditWorkbookRouteArgs(
            key: key,
            workbook: workbook,
          ),
        );

  static const String name = 'EditWorkbookRoute';
}

class EditWorkbookRouteArgs {
  const EditWorkbookRouteArgs({
    this.key,
    required this.workbook,
  });

  final Key? key;

  final Workbook workbook;

  @override
  String toString() {
    return 'EditWorkbookRouteArgs{key: $key, workbook: $workbook}';
  }
}

/// generated route for
/// [CreateQuestionPage]
class CreateQuestionRoute extends PageRouteInfo<CreateQuestionRouteArgs> {
  CreateQuestionRoute({
    Key? key,
    required String workbookId,
  }) : super(
          CreateQuestionRoute.name,
          path: 'create-question-page',
          args: CreateQuestionRouteArgs(
            key: key,
            workbookId: workbookId,
          ),
        );

  static const String name = 'CreateQuestionRoute';
}

class CreateQuestionRouteArgs {
  const CreateQuestionRouteArgs({
    this.key,
    required this.workbookId,
  });

  final Key? key;

  final String workbookId;

  @override
  String toString() {
    return 'CreateQuestionRouteArgs{key: $key, workbookId: $workbookId}';
  }
}

/// generated route for
/// [EditQuestionPage]
class EditQuestionRoute extends PageRouteInfo<EditQuestionRouteArgs> {
  EditQuestionRoute({
    Key? key,
    required String workbookId,
    required Question question,
  }) : super(
          EditQuestionRoute.name,
          path: 'edit-question-page',
          args: EditQuestionRouteArgs(
            key: key,
            workbookId: workbookId,
            question: question,
          ),
        );

  static const String name = 'EditQuestionRoute';
}

class EditQuestionRouteArgs {
  const EditQuestionRouteArgs({
    this.key,
    required this.workbookId,
    required this.question,
  });

  final Key? key;

  final String workbookId;

  final Question question;

  @override
  String toString() {
    return 'EditQuestionRouteArgs{key: $key, workbookId: $workbookId, question: $question}';
  }
}

/// generated route for
/// [SearchWorkbookPage]
class SearchWorkbookRoute extends PageRouteInfo<void> {
  const SearchWorkbookRoute()
      : super(
          SearchWorkbookRoute.name,
          path: '',
        );

  static const String name = 'SearchWorkbookRoute';
}

/// generated route for
/// [GroupListPage]
class GroupListRoute extends PageRouteInfo<void> {
  const GroupListRoute()
      : super(
          GroupListRoute.name,
          path: '',
        );

  static const String name = 'GroupListRoute';
}

/// generated route for
/// [GroupDetailsPage]
class GroupDetailsRoute extends PageRouteInfo<void> {
  const GroupDetailsRoute()
      : super(
          GroupDetailsRoute.name,
          path: 'group-details-page',
        );

  static const String name = 'GroupDetailsRoute';
}

/// generated route for
/// [RecordPage]
class RecordRoute extends PageRouteInfo<void> {
  const RecordRoute()
      : super(
          RecordRoute.name,
          path: '',
        );

  static const String name = 'RecordRoute';
}

/// generated route for
/// [SettingPage]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute()
      : super(
          SettingRoute.name,
          path: '',
        );

  static const String name = 'SettingRoute';
}

/// generated route for
/// [DebugPage]
class DebugRoute extends PageRouteInfo<void> {
  const DebugRoute()
      : super(
          DebugRoute.name,
          path: 'debug-page',
        );

  static const String name = 'DebugRoute';
}

/// generated route for
/// [TrashPage]
class TrashRoute extends PageRouteInfo<void> {
  const TrashRoute()
      : super(
          TrashRoute.name,
          path: 'trash-page',
        );

  static const String name = 'TrashRoute';
}
