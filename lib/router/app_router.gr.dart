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
    CreateQuestionRoute.name: (routeData) {
      final args = routeData.argsAs<CreateQuestionRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateQuestionPage(
          key: args.key,
          workbookId: args.workbookId,
          location: args.location,
        ),
        fullscreenDialog: true,
      );
    },
    AnswerWorkbookRoute.name: (routeData) {
      final args = routeData.argsAs<AnswerWorkbookRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: AnswerWorkbookPage(
          key: args.key,
          workbook: args.workbook,
        ),
        fullscreenDialog: true,
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
          location: args.location,
        ),
        fullscreenDialog: true,
      );
    },
    SignInRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
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
          location: args.location,
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
          location: args.location,
        ),
      );
    },
    CreateFolderRoute.name: (routeData) {
      final args = routeData.argsAs<CreateFolderRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateFolderPage(
          key: args.key,
          location: args.location,
        ),
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
          location: args.location,
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
    SelectWorkbookRoute.name: (routeData) {
      final args = routeData.argsAs<SelectWorkbookRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SelectWorkbookPage(
          key: args.key,
          title: args.title,
          location: args.location,
          onSelected: args.onSelected,
          folderId: args.folderId,
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
    CreateGroupRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CreateGroupPage(),
      );
    },
    GroupDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<GroupDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: GroupDetailsPage(
          key: args.key,
          groupId: args.groupId,
        ),
      );
    },
    CreateGroupWorkbookRoute.name: (routeData) {
      final args = routeData.argsAs<CreateGroupWorkbookRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateGroupWorkbookPage(
          key: args.key,
          groupId: args.groupId,
        ),
      );
    },
    CreateGroupWorkbookInFolderRoute.name: (routeData) {
      final args = routeData.argsAs<CreateGroupWorkbookInFolderRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateGroupWorkbookInFolderPage(
          key: args.key,
          folderId: args.folderId,
          groupId: args.groupId,
          location: args.location,
        ),
      );
    },
    EditGroupRoute.name: (routeData) {
      final args = routeData.argsAs<EditGroupRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: EditGroupPage(
          key: args.key,
          group: args.group,
        ),
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
                  SelectWorkbookRoute.name,
                  path: 'select-workbook-page',
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
                  CreateGroupRoute.name,
                  path: 'create-group-page',
                  parent: GroupTabRoute.name,
                ),
                RouteConfig(
                  GroupDetailsRoute.name,
                  path: 'group-details-page',
                  parent: GroupTabRoute.name,
                ),
                RouteConfig(
                  CreateGroupWorkbookRoute.name,
                  path: 'create-group-workbook-page',
                  parent: GroupTabRoute.name,
                ),
                RouteConfig(
                  CreateGroupWorkbookInFolderRoute.name,
                  path: 'create-group-workbook-in-folder-page',
                  parent: GroupTabRoute.name,
                ),
                RouteConfig(
                  EditGroupRoute.name,
                  path: 'edit-group-page',
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
          CreateQuestionRoute.name,
          path: '/create-question-page',
        ),
        RouteConfig(
          AnswerWorkbookRoute.name,
          path: '/answer-workbook-page',
        ),
        RouteConfig(
          EditQuestionRoute.name,
          path: '/edit-question-page',
        ),
        RouteConfig(
          SignInRoute.name,
          path: '/sign-in-page',
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
/// [CreateQuestionPage]
class CreateQuestionRoute extends PageRouteInfo<CreateQuestionRouteArgs> {
  CreateQuestionRoute({
    Key? key,
    required String workbookId,
    required AppDataLocation location,
  }) : super(
          CreateQuestionRoute.name,
          path: '/create-question-page',
          args: CreateQuestionRouteArgs(
            key: key,
            workbookId: workbookId,
            location: location,
          ),
        );

  static const String name = 'CreateQuestionRoute';
}

class CreateQuestionRouteArgs {
  const CreateQuestionRouteArgs({
    this.key,
    required this.workbookId,
    required this.location,
  });

  final Key? key;

  final String workbookId;

  final AppDataLocation location;

  @override
  String toString() {
    return 'CreateQuestionRouteArgs{key: $key, workbookId: $workbookId, location: $location}';
  }
}

/// generated route for
/// [AnswerWorkbookPage]
class AnswerWorkbookRoute extends PageRouteInfo<AnswerWorkbookRouteArgs> {
  AnswerWorkbookRoute({
    Key? key,
    required Workbook workbook,
  }) : super(
          AnswerWorkbookRoute.name,
          path: '/answer-workbook-page',
          args: AnswerWorkbookRouteArgs(
            key: key,
            workbook: workbook,
          ),
        );

  static const String name = 'AnswerWorkbookRoute';
}

class AnswerWorkbookRouteArgs {
  const AnswerWorkbookRouteArgs({
    this.key,
    required this.workbook,
  });

  final Key? key;

  final Workbook workbook;

  @override
  String toString() {
    return 'AnswerWorkbookRouteArgs{key: $key, workbook: $workbook}';
  }
}

/// generated route for
/// [EditQuestionPage]
class EditQuestionRoute extends PageRouteInfo<EditQuestionRouteArgs> {
  EditQuestionRoute({
    Key? key,
    required String workbookId,
    required Question question,
    required AppDataLocation location,
  }) : super(
          EditQuestionRoute.name,
          path: '/edit-question-page',
          args: EditQuestionRouteArgs(
            key: key,
            workbookId: workbookId,
            question: question,
            location: location,
          ),
        );

  static const String name = 'EditQuestionRoute';
}

class EditQuestionRouteArgs {
  const EditQuestionRouteArgs({
    this.key,
    required this.workbookId,
    required this.question,
    required this.location,
  });

  final Key? key;

  final String workbookId;

  final Question question;

  final AppDataLocation location;

  @override
  String toString() {
    return 'EditQuestionRouteArgs{key: $key, workbookId: $workbookId, question: $question, location: $location}';
  }
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in-page',
        );

  static const String name = 'SignInRoute';
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
    required AppDataLocation location,
  }) : super(
          FolderDetailsRoute.name,
          path: 'folder-details-page',
          args: FolderDetailsRouteArgs(
            key: key,
            folderId: folderId,
            location: location,
          ),
        );

  static const String name = 'FolderDetailsRoute';
}

class FolderDetailsRouteArgs {
  const FolderDetailsRouteArgs({
    this.key,
    required this.folderId,
    required this.location,
  });

  final Key? key;

  final String folderId;

  final AppDataLocation location;

  @override
  String toString() {
    return 'FolderDetailsRouteArgs{key: $key, folderId: $folderId, location: $location}';
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
    required AppDataLocation location,
  }) : super(
          CreateWorkbookRoute.name,
          path: 'create-workbook-page',
          args: CreateWorkbookRouteArgs(
            key: key,
            folder: folder,
            location: location,
          ),
        );

  static const String name = 'CreateWorkbookRoute';
}

class CreateWorkbookRouteArgs {
  const CreateWorkbookRouteArgs({
    this.key,
    required this.folder,
    required this.location,
  });

  final Key? key;

  final Folder? folder;

  final AppDataLocation location;

  @override
  String toString() {
    return 'CreateWorkbookRouteArgs{key: $key, folder: $folder, location: $location}';
  }
}

/// generated route for
/// [CreateFolderPage]
class CreateFolderRoute extends PageRouteInfo<CreateFolderRouteArgs> {
  CreateFolderRoute({
    Key? key,
    required AppDataLocation location,
  }) : super(
          CreateFolderRoute.name,
          path: 'create-folder-page',
          args: CreateFolderRouteArgs(
            key: key,
            location: location,
          ),
        );

  static const String name = 'CreateFolderRoute';
}

class CreateFolderRouteArgs {
  const CreateFolderRouteArgs({
    this.key,
    required this.location,
  });

  final Key? key;

  final AppDataLocation location;

  @override
  String toString() {
    return 'CreateFolderRouteArgs{key: $key, location: $location}';
  }
}

/// generated route for
/// [WorkbookDetailsPage]
class WorkbookDetailsRoute extends PageRouteInfo<WorkbookDetailsRouteArgs> {
  WorkbookDetailsRoute({
    Key? key,
    required String? folderId,
    required String workbookId,
    required AppDataLocation location,
  }) : super(
          WorkbookDetailsRoute.name,
          path: 'workbook-details-page',
          args: WorkbookDetailsRouteArgs(
            key: key,
            folderId: folderId,
            workbookId: workbookId,
            location: location,
          ),
        );

  static const String name = 'WorkbookDetailsRoute';
}

class WorkbookDetailsRouteArgs {
  const WorkbookDetailsRouteArgs({
    this.key,
    required this.folderId,
    required this.workbookId,
    required this.location,
  });

  final Key? key;

  final String? folderId;

  final String workbookId;

  final AppDataLocation location;

  @override
  String toString() {
    return 'WorkbookDetailsRouteArgs{key: $key, folderId: $folderId, workbookId: $workbookId, location: $location}';
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
/// [SelectWorkbookPage]
class SelectWorkbookRoute extends PageRouteInfo<SelectWorkbookRouteArgs> {
  SelectWorkbookRoute({
    Key? key,
    required String title,
    required AppDataLocation location,
    required void Function(Workbook) onSelected,
    String? folderId,
  }) : super(
          SelectWorkbookRoute.name,
          path: 'select-workbook-page',
          args: SelectWorkbookRouteArgs(
            key: key,
            title: title,
            location: location,
            onSelected: onSelected,
            folderId: folderId,
          ),
        );

  static const String name = 'SelectWorkbookRoute';
}

class SelectWorkbookRouteArgs {
  const SelectWorkbookRouteArgs({
    this.key,
    required this.title,
    required this.location,
    required this.onSelected,
    this.folderId,
  });

  final Key? key;

  final String title;

  final AppDataLocation location;

  final void Function(Workbook) onSelected;

  final String? folderId;

  @override
  String toString() {
    return 'SelectWorkbookRouteArgs{key: $key, title: $title, location: $location, onSelected: $onSelected, folderId: $folderId}';
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
/// [CreateGroupPage]
class CreateGroupRoute extends PageRouteInfo<void> {
  const CreateGroupRoute()
      : super(
          CreateGroupRoute.name,
          path: 'create-group-page',
        );

  static const String name = 'CreateGroupRoute';
}

/// generated route for
/// [GroupDetailsPage]
class GroupDetailsRoute extends PageRouteInfo<GroupDetailsRouteArgs> {
  GroupDetailsRoute({
    Key? key,
    required String groupId,
  }) : super(
          GroupDetailsRoute.name,
          path: 'group-details-page',
          args: GroupDetailsRouteArgs(
            key: key,
            groupId: groupId,
          ),
        );

  static const String name = 'GroupDetailsRoute';
}

class GroupDetailsRouteArgs {
  const GroupDetailsRouteArgs({
    this.key,
    required this.groupId,
  });

  final Key? key;

  final String groupId;

  @override
  String toString() {
    return 'GroupDetailsRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [CreateGroupWorkbookPage]
class CreateGroupWorkbookRoute
    extends PageRouteInfo<CreateGroupWorkbookRouteArgs> {
  CreateGroupWorkbookRoute({
    Key? key,
    required String groupId,
  }) : super(
          CreateGroupWorkbookRoute.name,
          path: 'create-group-workbook-page',
          args: CreateGroupWorkbookRouteArgs(
            key: key,
            groupId: groupId,
          ),
        );

  static const String name = 'CreateGroupWorkbookRoute';
}

class CreateGroupWorkbookRouteArgs {
  const CreateGroupWorkbookRouteArgs({
    this.key,
    required this.groupId,
  });

  final Key? key;

  final String groupId;

  @override
  String toString() {
    return 'CreateGroupWorkbookRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [CreateGroupWorkbookInFolderPage]
class CreateGroupWorkbookInFolderRoute
    extends PageRouteInfo<CreateGroupWorkbookInFolderRouteArgs> {
  CreateGroupWorkbookInFolderRoute({
    Key? key,
    required String folderId,
    required String groupId,
    required AppDataLocation location,
  }) : super(
          CreateGroupWorkbookInFolderRoute.name,
          path: 'create-group-workbook-in-folder-page',
          args: CreateGroupWorkbookInFolderRouteArgs(
            key: key,
            folderId: folderId,
            groupId: groupId,
            location: location,
          ),
        );

  static const String name = 'CreateGroupWorkbookInFolderRoute';
}

class CreateGroupWorkbookInFolderRouteArgs {
  const CreateGroupWorkbookInFolderRouteArgs({
    this.key,
    required this.folderId,
    required this.groupId,
    required this.location,
  });

  final Key? key;

  final String folderId;

  final String groupId;

  final AppDataLocation location;

  @override
  String toString() {
    return 'CreateGroupWorkbookInFolderRouteArgs{key: $key, folderId: $folderId, groupId: $groupId, location: $location}';
  }
}

/// generated route for
/// [EditGroupPage]
class EditGroupRoute extends PageRouteInfo<EditGroupRouteArgs> {
  EditGroupRoute({
    Key? key,
    required Group group,
  }) : super(
          EditGroupRoute.name,
          path: 'edit-group-page',
          args: EditGroupRouteArgs(
            key: key,
            group: group,
          ),
        );

  static const String name = 'EditGroupRoute';
}

class EditGroupRouteArgs {
  const EditGroupRouteArgs({
    this.key,
    required this.group,
  });

  final Key? key;

  final Group group;

  @override
  String toString() {
    return 'EditGroupRouteArgs{key: $key, group: $group}';
  }
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
