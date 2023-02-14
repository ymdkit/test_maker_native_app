import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';
import 'package:test_maker_native_app/state/questions_state.dart';
import 'package:test_maker_native_app/ui/widget/app_dropdown_button_form_field.dart';
import 'package:test_maker_native_app/ui/widget/app_section_title.dart';
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
    final questionType = useState(QuestionType.write);
    final problemController = useTextEditingController();
    final problemImageUrl = useState(null);
    final answerControllers = useState<List<TextEditingController>>([
      TextEditingController(),
    ]);
    final wrongChoiceControllers = useState<List<TextEditingController>>([]);
    final explanationController = useTextEditingController();
    final explanationImageUrl = useState(null);
    final isAutoGenerateWrongChoices = useState(false);
    final isCheckAnswerOrder = useState(false);

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
                      const AppSectionTitle(title: '必須項目'),
                      AppDropdownButtonFormField<QuestionType>(
                          value: questionType.value,
                          items: QuestionType.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toDisplayString()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              questionType.value = value;
                            }
                          },
                          labelText: '問題形式',
                          hintText: '問題形式を選択してください'),
                      const SizedBox(height: 16),
                      AppTextFormField(
                        autofocus: true,
                        controller: problemController,
                        hintText: '問題文を入力してください',
                        labelText: '問題文',
                        validator: (value) =>
                            value?.isEmpty ?? true ? '問題文を入力してください' : null,
                        maxLines: 5,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () => showAppSnackBar(context, '画像撮影'),
                            label: const Text('画像を追加'),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...answerControllers.value.mapIndexed(
                        (index, controller) => Column(
                          children: [
                            AppTextFormField(
                              controller: controller,
                              hintText: '答えを入力してください',
                              labelText: '答え',
                              validator: (value) =>
                                  value?.isEmpty ?? true ? '答えを入力してください' : null,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      if (questionType.value.hasWrongChoices())
                        ...wrongChoiceControllers.value.mapIndexed(
                          (index, controller) => Column(
                            children: [
                              AppTextFormField(
                                controller: controller,
                                hintText: '不正解の選択肢を入力してください',
                                labelText: '不正解の選択肢',
                                validator: (value) => value?.isEmpty ?? true
                                    ? '不正解の選択肢を入力してください'
                                    : null,
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      Visibility(
                        visible: questionType.value.hasMultipleAnswers(),
                        child: Column(
                          children: [
                            AppDropdownButtonFormField<int>(
                                value: answerControllers.value.length,
                                items: List.generate(
                                  11,
                                  (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text('$index'),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value != null) {
                                    answerControllers.value = List.generate(
                                      value,
                                      (index) =>
                                          TextEditingController.fromValue(
                                        TextEditingValue(
                                          text: answerControllers.value
                                                  .elementAtOrNull(index)
                                                  ?.text ??
                                              '',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                labelText: '答えの数',
                                hintText: '答えの数を選択してください'),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: questionType.value.hasWrongChoices(),
                        child: AppDropdownButtonFormField<int>(
                            value: wrongChoiceControllers.value.length,
                            items: List.generate(
                              11,
                              (index) => DropdownMenuItem(
                                value: index,
                                child: Text('$index'),
                              ),
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                wrongChoiceControllers.value = List.generate(
                                  value,
                                  (index) => TextEditingController.fromValue(
                                    TextEditingValue(
                                      text: wrongChoiceControllers.value
                                              .elementAtOrNull(index)
                                              ?.text ??
                                          '',
                                    ),
                                  ),
                                );
                              }
                            },
                            labelText: '不正解の数',
                            hintText: '不正解の数を選択してください'),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),
                      const AppSectionTitle(title: '任意項目'),
                      AppTextFormField(
                        controller: explanationController,
                        hintText: '解説を入力してください',
                        labelText: '解説',
                        maxLines: 5,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () => showAppSnackBar(context, '画像撮影'),
                            label: const Text('画像を追加'),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Visibility(
                        visible: questionType.value.hasWrongChoices(),
                        child: CheckboxListTile(
                          value: isAutoGenerateWrongChoices.value,
                          onChanged: (value) {
                            if (value != null) {
                              isAutoGenerateWrongChoices.value = value;
                            }
                          },
                          title: const Text('不正解の選択肢を自動生成する'),
                        ),
                      ),
                      Visibility(
                        visible: questionType.value.hasMultipleAnswers(),
                        child: CheckboxListTile(
                          value: isCheckAnswerOrder.value,
                          onChanged: (value) {
                            if (value != null) {
                              isCheckAnswerOrder.value = value;
                            }
                          },
                          title: const Text('解答順序をチェックする'),
                        ),
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
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      ref
                          .read(questionsProvider(workbookId).notifier)
                          .addQuestion(
                            workbookId: workbookId,
                            questionType: questionType.value,
                            problem: problemController.text,
                            problemImageUrl: problemImageUrl.value,
                            answers: answerControllers.value
                                .map((e) => e.text)
                                .toList(),
                            wrongChoices: wrongChoiceControllers.value
                                .map((e) => e.text)
                                .toList(),
                            explanation: explanationController.text,
                            explanationImageUrl: explanationImageUrl.value,
                            isAutoGenerateWrongChoices:
                                isAutoGenerateWrongChoices.value,
                            isCheckAnswerOrder: isCheckAnswerOrder.value,
                          );
                      showAppSnackBar(context, '問題を作成しました');
                      //TODO 入力値のリセット
                      formKey.currentState?.reset();
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
