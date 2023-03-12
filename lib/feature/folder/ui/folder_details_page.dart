import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/state/folder_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/ui/operate_workbook_sheet.dart';
import 'package:test_maker_native_app/feature/workbook/ui/workbook_list_item.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class FolderDetailsPage extends HookConsumerWidget {
  const FolderDetailsPage({
    super.key,
    required this.folderId,
    required this.location,
  });

  final String folderId;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(folderProvider(
      folderId: folderId,
      key: FoldersStateKey(location: location),
    ));
    final workbooks = ref.watch(
      workbooksProvider(
        WorkbooksStateKey(
          location: folder.location,
          folderId: folderId,
        ),
      ),
    );

    return AppAdWrapper(
      adUnitId: AppAdUnitId.folderDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(folder.title),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: _PopupMenuItems.edit,
                  child: Text(
                    AppLocalizations.of(context)!.menuEditFolder,
                  ),
                ),
                PopupMenuItem(
                  value: _PopupMenuItems.delete,
                  child: Text(
                    AppLocalizations.of(context)!.menuDeleteFolder,
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case _PopupMenuItems.edit:
                    context.router.push(
                      EditFolderRoute(folder: folder),
                    );
                    break;
                  case _PopupMenuItems.delete:
                    showAlertDialog(
                      context: context,
                      title: AppLocalizations.of(context)!.titleDeleteFolder,
                      content:
                          AppLocalizations.of(context)!.confirmDeleteFolder,
                      isDangerous: true,
                      positiveButtonText:
                          AppLocalizations.of(context)!.buttonDelete,
                      onPositive: () async {
                        final result = await ref
                            .read(foldersProvider(FoldersStateKey.from(folder))
                                .notifier)
                            .deleteFolder(folder);

                        result.match(
                          (l) => showAppSnackBar(context, l.message),
                          (r) {
                            showAppSnackBar(
                              context,
                              AppLocalizations.of(context)!
                                  .messageDeleteFolderSuccess,
                            );
                            context.router.pop();
                          },
                        );
                      },
                    );
                    break;
                }
              },
            ),
          ],
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
                    onTap: (workbook) async =>
                        showOperateWorkbookSheet(context, workbook),
                  ),
                ),
          failure: (_) => AppErrorContent.serverError(context: context),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'folder_details_page',
          onPressed: () => context.router.push(
            CreateWorkbookRoute(folder: folder, location: location),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

enum _PopupMenuItems {
  edit,
  delete,
}
