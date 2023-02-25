import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/account/ui/sign_in_page.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_workbook_page.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/ui/create_folder_page.dart';
import 'package:test_maker_native_app/feature/folder/ui/edit_folder_page.dart';
import 'package:test_maker_native_app/feature/folder/ui/folder_details_page.dart';
import 'package:test_maker_native_app/feature/group/model/group.dart';
import 'package:test_maker_native_app/feature/group/ui/create_group_page.dart';
import 'package:test_maker_native_app/feature/group/ui/create_group_workbook_in_folder_page.dart';
import 'package:test_maker_native_app/feature/group/ui/create_group_workbook_page.dart';
import 'package:test_maker_native_app/feature/group/ui/edit_group_page.dart';
import 'package:test_maker_native_app/feature/group/ui/group_details_page.dart';
import 'package:test_maker_native_app/feature/group/ui/group_list_page.dart';
import 'package:test_maker_native_app/feature/home/ui/home_page.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/ui/create_question_page.dart';
import 'package:test_maker_native_app/feature/question/ui/edit_question_page.dart';
import 'package:test_maker_native_app/feature/question/ui/select_workbook_page.dart';
import 'package:test_maker_native_app/feature/record/ui/record_page.dart';
import 'package:test_maker_native_app/feature/search/ui/search_workbook_page.dart';
import 'package:test_maker_native_app/feature/setting/ui/debug_page.dart';
import 'package:test_maker_native_app/feature/setting/ui/setting_page.dart';
import 'package:test_maker_native_app/feature/trash/ui/trash_page.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/ui/create_workbook_page.dart';
import 'package:test_maker_native_app/feature/workbook/ui/edit_workbook_page.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_details_page.dart';
import 'package:test_maker_native_app/main.dart';

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
            AutoRoute(page: HomePage, initial: true),
            AutoRoute(page: FolderDetailsPage),
            AutoRoute(page: EditFolderPage),
            AutoRoute(page: CreateWorkbookPage),
            AutoRoute(page: CreateFolderPage),
            AutoRoute(page: WorkbookDetailsPage),
            AutoRoute(page: EditWorkbookPage),
            AutoRoute(page: SelectWorkbookPage),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'SearchTabRoute',
          children: [
            AutoRoute(page: SearchWorkbookPage, initial: true),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'GroupTabRoute',
          children: [
            AutoRoute(page: GroupListPage, initial: true),
            AutoRoute(page: CreateGroupPage),
            AutoRoute(page: GroupDetailsPage),
            AutoRoute(page: CreateGroupWorkbookPage),
            AutoRoute(page: CreateGroupWorkbookInFolderPage),
            AutoRoute(page: EditGroupPage),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'RecordTabRoute',
          children: [
            AutoRoute(page: RecordPage, initial: true),
          ],
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'SettingTabRoute',
          children: [
            AutoRoute(page: SettingPage, initial: true),
            AutoRoute(page: DebugPage),
            AutoRoute(page: TrashPage),
          ],
        ),
      ],
    ),
    AutoRoute(page: CreateQuestionPage, fullscreenDialog: true),
    AutoRoute(page: AnswerWorkbookPage, fullscreenDialog: true),
    AutoRoute(page: EditQuestionPage, fullscreenDialog: true),
    AutoRoute(page: SignInPage, fullscreenDialog: true),
  ],
)
class AppRouter extends _$AppRouter {}
