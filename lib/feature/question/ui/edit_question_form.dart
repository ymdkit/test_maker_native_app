import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  EditQuestionForm.create({
    super.key,
    required BuildContext context,
    required this.workbookId,
    required this.onSubmit,
    required this.location,
  })  : title = AppLocalizations.of(context)!.titleCreateQuestion,
        submitButtonText = AppLocalizations.of(context)!.buttonCreateQuestion,
        completionMessage =
            AppLocalizations.of(context)!.messageCreateQuestionSuccess,
        question = null;

  EditQuestionForm.edit({
    super.key,
    required BuildContext context,
    required this.workbookId,
    required this.question,
    required this.onSubmit,
    required this.location,
  })  : title = AppLocalizations.of(context)!.titleEditQuestion,
        submitButtonText = AppLocalizations.of(context)!.buttonUpdate,
        completionMessage = AppLocalizations.of(context)!.messageUpdateSuccess;

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
                            AppSectionTitle(
                              title:
                                  AppLocalizations.of(context)!.sectionRequired,
                            ),
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
                              labelText: AppLocalizations.of(context)!
                                  .labelQuestionType,
                              hintText: AppLocalizations.of(context)!
                                  .hintQuestionType,
                            ),
                            const SizedBox(height: 16),
                            AppTextFormField(
                              focusNode: firstFormFocusNode,
                              autofocus: true,
                              controller: problemController,
                              hintText: AppLocalizations.of(context)!
                                  .hintQuestionProblem,
                              labelText: AppLocalizations.of(context)!
                                  .labelQuestionProblem,
                              validator: (value) => value?.isEmpty ?? true
                                  ? AppLocalizations.of(context)!
                                      .hintQuestionProblem
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
                                    hintText: AppLocalizations.of(context)!
                                        .hintQuestionAnswer,
                                    labelText: AppLocalizations.of(context)!
                                        .labelQuestionAnswer,
                                    validator: (value) => value?.isEmpty ?? true
                                        ? AppLocalizations.of(context)!
                                            .hintQuestionAnswer
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
                                      hintText: AppLocalizations.of(context)!
                                          .hintQuestionWrongChoice,
                                      labelText: AppLocalizations.of(context)!
                                          .labelQuestionWrongChoice,
                                      validator: !isAutoGenerateWrongChoices
                                              .value
                                          ? (value) => value?.isEmpty ?? true
                                              ? AppLocalizations.of(context)!
                                                  .hintQuestionWrongChoice
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
                                    labelText: AppLocalizations.of(context)!
                                        .labelQuestionAnswerCount,
                                    hintText: AppLocalizations.of(context)!
                                        .hintQuestionAnswerCount,
                                  ),
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
                                labelText: AppLocalizations.of(context)!
                                    .labelQuestionWrongChoiceCount,
                                hintText: AppLocalizations.of(context)!
                                    .hintQuestionWrongChoiceCount,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 16),
                            AppSectionTitle(
                              title:
                                  AppLocalizations.of(context)!.sectionOptional,
                            ),
                            AppTextFormField(
                              controller: explanationController,
                              hintText: AppLocalizations.of(context)!
                                  .hintQuestionExplanation,
                              labelText: AppLocalizations.of(context)!
                                  .labelQuestionExplanation,
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
                                title: Text(AppLocalizations.of(context)!
                                    .labelIsAutoGenerateWrongChoice),
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
                                title: Text(
                                  AppLocalizations.of(context)!
                                      .labelIsCheckAnswerOrder,
                                ),
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
                            showAppSnackBar(
                              context,
                              AppLocalizations.of(context)!.messageInvalidInput,
                            );
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
