import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/state/folders_state.dart';
import 'package:test_maker_native_app/ui/widget/app_color_drop_down_button_form_field.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/ui/widget/app_text_form_field.dart';

class CreateFolderPage extends HookConsumerWidget {
  const CreateFolderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final folderTitleController = useTextEditingController();
    final selectedColor = useState(ColorTheme.blue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('フォルダの作成'),
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
                        controller: folderTitleController,
                        hintText: 'フォルダ名を入力してください',
                        labelText: 'フォルダ名',
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'フォルダ名を入力してください' : null,
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
                      ref.read(foldersProvider.notifier).addFolder(
                            title: folderTitleController.text,
                            color: selectedColor.value,
                          );
                      showAppSnackBar(context, 'フォルダを作成しました');
                      context.router.pop();
                    } else {
                      showAppSnackBar(context, '入力内容に不備があります');
                    }
                  },
                  child: const Text('フォルダを作成する'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}