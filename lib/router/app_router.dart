import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/main.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/ui/page/folder/create_folder_page.dart';
import 'package:test_maker_native_app/ui/page/folder/edit_folder_page.dart';
import 'package:test_maker_native_app/ui/page/folder/folder_details_page.dart';
import 'package:test_maker_native_app/ui/page/group/group_details_page.dart';
import 'package:test_maker_native_app/ui/page/group/group_list_page.dart';
import 'package:test_maker_native_app/ui/page/home/home_page.dart';
import 'package:test_maker_native_app/ui/page/question/create_question_page.dart';
import 'package:test_maker_native_app/ui/page/question/edit_question_page.dart';
import 'package:test_maker_native_app/ui/page/record/record_page.dart';
import 'package:test_maker_native_app/ui/page/search/search_workbook_page.dart';
import 'package:test_maker_native_app/ui/page/setting/debug_page.dart';
import 'package:test_maker_native_app/ui/page/setting/setting_page.dart';
import 'package:test_maker_native_app/ui/page/setting/trash_page.dart';
import 'package:test_maker_native_app/ui/page/workbook/answer_workbook_page.dart';
import 'package:test_maker_native_app/ui/page/workbook/answer_workbook_result_page.dart';
import 'package:test_maker_native_app/ui/page/workbook/create_workbook_page.dart';
import 'package:test_maker_native_app/ui/page/workbook/edit_workbook_page.dart';
import 'package:test_maker_native_app/ui/page/workbook/workbook_details_page.dart';

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
            AutoRoute(page: CreateQuestionPage),
            AutoRoute(page: EditQuestionPage),
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
            AutoRoute(page: GroupDetailsPage),
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
    AutoRoute(page: AnswerWorkbookPage, fullscreenDialog: true),
    AutoRoute(page: AnswerWorkbookResultPage, fullscreenDialog: true),
  ],
)
class AppRouter extends _$AppRouter {}
