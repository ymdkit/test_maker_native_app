import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/utils/app_image.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_dropdown_button_form_field.dart';
import 'package:test_maker_native_app/widget/app_pick_image_button.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';

class EditQuestionForm extends HookConsumerWidget {
  const EditQuestionForm({
    super.key,
    required this.workbookId,
    required this.question,
    required this.title,
    required this.submitButtonText,
    required this.completionMessage,
    required this.location,
    required this.onSubmit,
  });

  final String workbookId;
  final Question? question;
  final String title;
  final String submitButtonText;
  final String completionMessage;
  final AppDataLocation location;
  final void Function({
    required String workbookId,
    required QuestionType questionType,
    required String problem,
    required AppImage problemImage,
    required List<String> answers,
    required List<String> wrongChoices,
    required String? explanation,
    required AppImage explanationImage,
    required bool isAutoGenerateWrongChoices,
    required bool isCheckAnswerOrder,
  }) onSubmit;

  const EditQuestionForm.create({
    super.key,
    required this.workbookId,
    required this.onSubmit,
    required this.location,
  })  : title = '問題の作成',
        submitButtonText = '問題を作成する',
        completionMessage = '問題を作成しました',
        question = null;

  const EditQuestionForm.edit({
    super.key,
    required this.workbookId,
    required this.question,
    required this.onSubmit,
    required this.location,
  })  : title = '問題の編集',
        submitButtonText = '編集内容を保存する',
        completionMessage = '編集内容を保存しました';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenFocusNode = useFocusNode();
    final firstFormFocusNode = useFocusNode();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final questionType = useState(question?.questionType ?? QuestionType.write);
    final problemController = useTextEditingController(text: question?.problem);
    final problemImage =
        useState(question?.problemImage ?? const AppImage.empty());
    final answerControllers = useState<List<TextEditingController>>(
      question?.answers
              .map((text) => TextEditingController(text: text))
              .toList() ??
          [TextEditingController()],
    );
    final wrongChoiceControllers = useState<List<TextEditingController>>(
      question?.wrongChoices
              .map((text) => TextEditingController(text: text))
              .toList() ??
          [],
    );
    final explanationController = useTextEditingController();
    final explanationImageUrl =
        useState(question?.explanationImage ?? const AppImage.empty());
    final isAutoGenerateWrongChoices =
        useState(question?.isAutoGenerateWrongChoices ?? false);
    final isCheckAnswerOrder = useState(question?.isCheckAnswerOrder ?? false);

    return Focus(
      focusNode: screenFocusNode,
      child: GestureDetector(
        onTap: screenFocusNode.requestFocus,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: AppAdWrapper(
            adUnitId: AppAdUnitId.editQuestionBanner,
            child: Column(
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

                                    switch (value) {
                                      case QuestionType.write:
                                        answerControllers.value = [
                                          TextEditingController(),
                                        ];
                                        wrongChoiceControllers.value = [];
                                        break;
                                      case QuestionType.select:
                                        answerControllers.value = [
                                          TextEditingController(),
                                        ];
                                        wrongChoiceControllers.value = [
                                          TextEditingController(),
                                          TextEditingController(),
                                          TextEditingController(),
                                        ];
                                        break;
                                      case QuestionType.complete:
                                        answerControllers.value = [
                                          TextEditingController(),
                                          TextEditingController(),
                                        ];
                                        wrongChoiceControllers.value = [];
                                        break;
                                      case QuestionType.selectComplete:
                                        answerControllers.value = [
                                          TextEditingController(),
                                          TextEditingController(),
                                        ];
                                        wrongChoiceControllers.value = [
                                          TextEditingController(),
                                          TextEditingController(),
                                        ];
                                        break;
                                    }
                                  }
                                },
                                labelText: '問題形式',
                                hintText: '問題形式を選択してください'),
                            const SizedBox(height: 16),
                            AppTextFormField(
                              focusNode: firstFormFocusNode,
                              autofocus: true,
                              controller: problemController,
                              hintText: '問題文を入力してください',
                              labelText: '問題文',
                              validator: (value) => value?.isEmpty ?? true
                                  ? '問題文を入力してください'
                                  : null,
                              maxLines: 5,
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                AppPickImageButton(
                                  image: problemImage.value,
                                  onPicked: (filePath) async {
                                    problemImage.value = filePath;
                                  },
                                  location: location,
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
                                    validator: (value) => value?.isEmpty ?? true
                                        ? '答えを入力してください'
                                        : null,
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
                                      enabled:
                                          !isAutoGenerateWrongChoices.value,
                                      controller: controller,
                                      hintText: '不正解の選択肢を入力してください',
                                      labelText: '不正解の選択肢',
                                      validator: !isAutoGenerateWrongChoices
                                              .value
                                          ? (value) => value?.isEmpty ?? true
                                              ? '不正解の選択肢を入力してください'
                                              : null
                                          : null,
                                      textInputAction: TextInputAction.next,
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
                                          answerControllers.value =
                                              List.generate(
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
                                    wrongChoiceControllers.value =
                                        List.generate(
                                      value,
                                      (index) =>
                                          TextEditingController.fromValue(
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
                                hintText: '不正解の数を選択してください',
                              ),
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
                                AppPickImageButton(
                                  image: explanationImageUrl.value,
                                  onPicked: (filePath) async {
                                    explanationImageUrl.value = filePath;
                                  },
                                  location: location,
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
                            onSubmit(
                              workbookId: workbookId,
                              questionType: questionType.value,
                              problem: problemController.text,
                              problemImage: problemImage.value,
                              answers: answerControllers.value
                                  .map((e) => e.text)
                                  .toList(),
                              wrongChoices: wrongChoiceControllers.value
                                  .map((e) => e.text)
                                  .toList(),
                              explanation: explanationController.text,
                              explanationImage: explanationImageUrl.value,
                              isAutoGenerateWrongChoices:
                                  isAutoGenerateWrongChoices.value,
                              isCheckAnswerOrder: isCheckAnswerOrder.value,
                            );

                            showAppSnackBar(context, completionMessage);

                            // 入力内容をリセット
                            problemController.clear();
                            problemImage.value = const AppImage.empty();
                            for (final controller in answerControllers.value) {
                              controller.clear();
                            }
                            for (final controller
                                in wrongChoiceControllers.value) {
                              controller.clear();
                            }
                            explanationController.clear();
                            explanationImageUrl.value = const AppImage.empty();

                            // フォーカスを問題文に戻す
                            firstFormFocusNode.requestFocus();
                          } else {
                            showAppSnackBar(context, '入力内容に不備があります');
                          }
                        },
                        child: Text(submitButtonText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
