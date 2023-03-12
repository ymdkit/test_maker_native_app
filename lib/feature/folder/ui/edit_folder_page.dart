import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state.dart';
import 'package:test_maker_native_app/feature/folder/state/folders_state_key.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_color_drop_down_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';

class EditFolderPage extends HookConsumerWidget {
  const EditFolderPage({
    super.key,
    required this.folder,
  });

  final Folder folder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final folderTitleController = useTextEditingController(text: folder.title);
    final selectedColor = useState(folder.color);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.editFolderBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('フォルダの編集'),
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
                        const SizedBox(height: 16),
                        AppTextFormField(
                          autofocus: true,
                          controller: folderTitleController,
                          hintText:
                              AppLocalizations.of(context)!.hintFolderName,
                          labelText: 'フォルダ名',
                          validator: (value) => value?.isEmpty ?? true
                              ? AppLocalizations.of(context)!.hintFolderName
                              : null,
                        ),
                        const SizedBox(height: 16),
                        AppColorDropdownButtonFormField(
                          selectedColor: selectedColor.value,
                          onChanged: (colorTheme) =>
                              selectedColor.value = colorTheme,
                        ),
                        const SizedBox(height: 16),
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
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ref
                            .read(foldersProvider(FoldersStateKey.from(folder))
                                .notifier)
                            .updateFolder(
                              currentFolder: folder,
                              title: folderTitleController.text,
                              color: selectedColor.value,
                            );
                        showAppSnackBar(context, '編集内容を保存しました');
                        context.router.pop();
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
