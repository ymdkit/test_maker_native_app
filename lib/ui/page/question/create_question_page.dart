import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/ui/widget/app_text_form_field.dart';

class CreateQuestionPage extends HookConsumerWidget {
  const CreateQuestionPage({
    super.key,
    required this.workbookId,
  });

  final String workbookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final problemController = useTextEditingController();
    final answerControllers = useState<List<TextEditingController>>([
      useTextEditingController(),
      useTextEditingController(),
      useTextEditingController(),
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('問題の作成'),
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
                        controller: problemController,
                        hintText: '問題文を入力してください',
                        labelText: '問題文',
                        validator: (value) =>
                            value?.isEmpty ?? true ? '問題文を入力してください' : null,
                      ),
                      const SizedBox(height: 16),
                      ...answerControllers.value.mapIndexed(
                        (index, controller) => Column(
                          children: [
                            AppTextFormField(
                              controller: controller,
                              hintText: '答えを入力してください',
                              labelText: '${index + 1}つ目の答え',
                              validator: (value) =>
                                  value?.isEmpty ?? true ? '答えを入力してください' : null,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      )
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
                      showAppSnackBar(context, '問題を作成しました');
                      context.router.pop();
                    } else {
                      showAppSnackBar(context, '入力内容に不備があります');
                    }
                  },
                  child: const Text('問題を作成する'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
