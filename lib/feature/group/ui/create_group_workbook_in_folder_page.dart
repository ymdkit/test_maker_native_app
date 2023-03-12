import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/state/folder_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';
import 'package:test_maker_native_app/feature/group/state/group_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class CreateGroupWorkbookInFolderPage extends HookConsumerWidget {
  const CreateGroupWorkbookInFolderPage({
    super.key,
    required this.folderId,
    required this.groupId,
    required this.location,
  });

  final String folderId;
  final String groupId;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(folderProvider(
        folderId: folderId, key: FoldersStateKey(location: location)));
    final workbooks = ref.watch(
      workbooksProvider(
        WorkbooksStateKey(
          location: location,
          folderId: folderId,
        ),
      ),
    );

    return AppAdWrapper(
      adUnitId: AppAdUnitId.folderDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(folder.title),
        ),
        body: workbooks.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (workbooks) => workbooks.isEmpty
              ? AppEmptyContent.workbook(
                  context: context,
                  onPressedFallbackButton: () => context.router.push(
                    CreateWorkbookRoute(folder: folder, location: location),
                  ),
                )
              : ListView.builder(
                  itemCount: workbooks.length,
                  itemBuilder: (context, index) => WorkbookListItem(
                      workbook: workbooks[index],
                      onTap: (workbook) async {
                        final result = await ref
                            .read(groupWorkbooksStateProvider(groupId).notifier)
                            .addWorkbookToGroup(workbook: workbook);

                        result.match(
                          (l) => showAppSnackBar(context, l.message),
                          (r) {
                            showAppSnackBar(
                              context,
                              AppLocalizations.of(context)!
                                  .messageLinkWorkbookToGroupSuccess,
                            );
                            context.router.popUntil(
                              (route) =>
                                  route.settings.name == GroupDetailsRoute.name,
                            );
                          },
                        );
                      }),
                ),
          failure: (_) => AppErrorContent.serverError(context: context),
        ),
      ),
    );
  }
}
