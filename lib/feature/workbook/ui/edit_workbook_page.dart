import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_color_drop_down_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_folder_dropdown_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/widget/synchronized_button.dart';

class EditWorkbookPage extends HookConsumerWidget {
  const EditWorkbookPage({
    super.key,
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final workbookTitleController =
        useTextEditingController(text: workbook.title);
    final selectedColor = useState(workbook.color);
    final selectedFolder = useState<Folder?>(
      folders.firstWhereOrNull(
        (folder) => folder.folderId == workbook.folderId,
      ),
    );

    return AppAdWrapper(
      adUnitId: AppAdUnitId.editWorkbookBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('問題集の編集'),
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
                        AppTextFormField(
                          autofocus: true,
                          controller: workbookTitleController,
                          hintText: '問題集のタイトルを入力してください',
                          labelText: '問題集のタイトル',
                          validator: (value) => value?.isEmpty ?? true
                              ? '問題集のタイトルを入力してください'
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
                          folders: folders,
                          onChanged: (folder) => selectedFolder.value = folder,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton.icon(
                              onPressed: () => context.router.push(
                                const CreateFolderRoute(),
                              ),
                              label: const Text('フォルダ作成'),
                              icon: const Icon(Icons.add),
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
                            .read(workbooksProvider(
                                    selectedFolder.value?.folderId)
                                .notifier)
                            .addWorkbook(
                              title: workbookTitleController.text,
                              color: selectedColor.value,
                              folderId: selectedFolder.value?.folderId,
                            );

                        result.match(
                          (l) => showAppSnackBar(
                            context,
                            l.message,
                          ),
                          (_) {
                            showAppSnackBar(context, '問題集を編集しました');
                            context.router.pop();
                          },
                        );
                      } else {
                        showAppSnackBar(context, '入力内容に不備があります');
                      }
                    },
                    child: const Text('編集内容を保存する'),
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
