import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx_io.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/constants/web_url.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/utils/url_launcher.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_color_drop_down_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_folder_dropdown_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/widget/synchronized_button.dart';

class CreateWorkbookPage extends HookConsumerWidget {
  const CreateWorkbookPage({
    super.key,
    required this.folder,
    required this.location,
  });

  final Folder? folder;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foldersState =
        ref.watch(foldersProvider(FoldersStateKey(location: location)));

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final workbookTitleController = useTextEditingController();
    final selectedColor = useState(AppThemeColor.blue);
    final selectedFolder = useState<Folder?>(folder);
    final isOnlySharedByLink = useState(false);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.createWorkbookBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.titleCreateWorkbook,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppSectionTitle(
                            title: AppLocalizations.of(context)!
                                .sectionCreateWorkbookInApp),
                        AppTextFormField(
                          autofocus: true,
                          controller: workbookTitleController,
                          hintText:
                              AppLocalizations.of(context)!.hintWorkbookName,
                          labelText:
                              AppLocalizations.of(context)!.labelWorkbookName,
                          validator: (value) => value?.isEmpty ?? true
                              ? AppLocalizations.of(context)!.hintWorkbookName
                              : null,
                        ),
                        const SizedBox(height: 16),
                        AppColorDropdownButtonFormField(
                          selectedColor: selectedColor.value,
                          onChanged: (colorTheme) =>
                              selectedColor.value = colorTheme,
                        ),
                        const SizedBox(height: 16),
                        AppFolderDropdownButtonFormField(
                          selectedFolder: selectedFolder.value,
                          folders: foldersState.maybeWhen(
                            orElse: () => [],
                            success: (folders) => folders,
                          ),
                          onChanged: (folder) => selectedFolder.value = folder,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () => context.router.push(
                                CreateFolderRoute(location: location),
                              ),
                              label: Text(AppLocalizations.of(context)!
                                  .buttonCreateFolder),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: location == AppDataLocation.remoteOwned,
                          child: CheckboxListTile(
                            title: Text(
                              AppLocalizations.of(context)!
                                  .labelIsOnlyShareByLink,
                            ),
                            value: isOnlySharedByLink.value,
                            onChanged: (value) =>
                                isOnlySharedByLink.value = value ?? false,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        AppSectionTitle(
                            title: AppLocalizations.of(context)!
                                .sectionCreateWorkbookOther),
                        SynchronizedButton.outlined(
                          onPressed: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['csv'],
                            );

                            if (result != null) {
                              final file = File(result.files.single.path ?? '');
                              final text = await file.readAsLines();

                              final importResult = await ref
                                  .read(workbooksProvider(WorkbooksStateKey(
                                    location: location,
                                    folderId: selectedFolder.value?.folderId,
                                  )).notifier)
                                  .importWorkbook(
                                    workbookTitle: file.nameWithoutExtension,
                                    text: text.join('\r??n'),
                                  );

                              importResult.match(
                                (l) => showAppSnackBar(
                                    context, l.message.displayString(context)),
                                (r) async {
                                  showAppSnackBar(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .messageImportWorkbookSuccess,
                                  );
                                  await context.router.pop();
                                },
                              );
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.buttonImport,
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () => ref
                                  .read(urlLauncherProvider)
                                  .launch(WebUrl.importHelp),
                              label: Text(
                                AppLocalizations.of(context)!.labelHowToImport,
                              ),
                              icon: const Icon(Icons.help_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SynchronizedButton.elevated(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final result = await ref
                            .read(workbooksProvider(WorkbooksStateKey(
                              location: location,
                              folderId: selectedFolder.value?.folderId,
                            )).notifier)
                            .addWorkbook(
                              title: workbookTitleController.text,
                              color: selectedColor.value,
                              folderId: selectedFolder.value?.folderId,
                              isPublic: !isOnlySharedByLink.value,
                            );

                        result.match(
                          (l) => showAppSnackBar(
                              context, l.message.displayString(context)),
                          (r) async {
                            showAppSnackBar(
                              context,
                              AppLocalizations.of(context)!
                                  .messageCreateWorkbookSuccess,
                            );
                            await context.router.pop();
                          },
                        );
                      } else {
                        showAppSnackBar(
                          context,
                          AppLocalizations.of(context)!.messageInvalidInput,
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.buttonCreateWorkbook,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
