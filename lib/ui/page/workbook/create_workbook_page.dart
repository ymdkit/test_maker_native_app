import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/state/folders_state.dart';
import 'package:test_maker_native_app/ui/widget/app_dropdown_button_form_field.dart';
import 'package:test_maker_native_app/ui/widget/app_section_title.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/ui/widget/app_text_form_field.dart';

class CreateWorkbookPage extends HookConsumerWidget {
  const CreateWorkbookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final workbookTitleController = useTextEditingController();
    final selectedColor = useState(ColorTheme.blue);
    final selectedFolder = useState<Folder?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('問題集の作成'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AppSectionTitle(title: 'アプリで作成'),
                      AppTextFormField(
                        controller: workbookTitleController,
                        hintText: '問題集のタイトルを入力してください',
                        labelText: '問題集のタイトル',
                        validator: (value) =>
                            value?.isEmpty ?? true ? '問題集のタイトルを入力してください' : null,
                      ),
                      const SizedBox(height: 16),
                      AppDropdownButtonFormField(
                        value: selectedColor.value,
                        items: ColorTheme.values
                            .map(
                              (colorTheme) => DropdownMenuItem<ColorTheme?>(
                                value: colorTheme,
                                child: Text(colorTheme.displayString()),
                              ),
                            )
                            .toList(),
                        onChanged: (colorTheme) =>
                            selectedColor.value = colorTheme ?? ColorTheme.blue,
                        labelText: 'カラー',
                        hintText: 'カラーを選択してください',
                      ),
                      const SizedBox(height: 16),
                      // TODO(ymdkit): フォルダの新規作成をサポート
                      AppDropdownButtonFormField(
                        value: selectedFolder.value,
                        items: folders
                            .map((folder) => DropdownMenuItem<Folder?>(
                                  value: folder,
                                  child: Text(folder.title),
                                ))
                            .toList(),
                        onChanged: (folder) => selectedFolder.value = folder,
                        labelText: 'フォルダ',
                        hintText: 'フォルダを選択してください',
                      ),
                      const SizedBox(height: 32),
                      const AppSectionTitle(title: 'その他の方法で作成'),
                      OutlinedButton(
                        // TODO(ymdkit): ファイルのインポート機能を実装する
                        onPressed: () => showAppSnackBar(context, 'ファイルのインポート'),
                        child: const Text('ファイルのインポート'),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () =>
                            showAppSnackBar(context, 'ファイルのインポートとは？'),
                        child: const Text('ファイルのインポートとは？'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  showAppSnackBar(context, '問題集を作成しました');
                  context.router.pop();
                } else {
                  showAppSnackBar(context, '入力内容に不備があります');
                }
              },
              child: const Text('問題集を作成する'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}