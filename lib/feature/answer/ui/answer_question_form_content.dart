import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/answer/model/answering_question.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_effect_widget.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_problem_section.dart';
import 'package:test_maker_native_app/feature/answer/usecase/check_is_correct_use_case.dart';
import 'package:test_maker_native_app/feature/question/model/question_type.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/widget/separated_flex.dart';
import 'package:test_maker_native_app/widget/synchronized_button.dart';

class AnswerQuestionFormContent extends HookConsumerWidget {
  const AnswerQuestionFormContent({
    super.key,
    required this.question,
  });

  final AnsweringQuestion question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingAnswers = useState<List<String>>([]);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnswerProblemSection(question: question),
                  (() {
                    switch (question.questionType) {
                      case QuestionType.write:
                        return _AnswerWriteQuestionContent(
                          onChanged: (value) => editingAnswers.value = [value],
                        );
                      case QuestionType.select:
                        return _AnswerSelectQuestionContent(
                          question: question,
                          onSelected: (value) {
                            editingAnswers.value = [value];
                            _checkIsCorrectYourAnswer(
                                context, ref, editingAnswers.value);
                          },
                        );
                      case QuestionType.complete:
                        return _AnswerCompleteQuestionContent(
                          question: question,
                          onChanged: (value) => editingAnswers.value = value,
                        );
                      case QuestionType.selectComplete:
                        return _AnswerSelectCompleteQuestionContent(
                          question: question,
                          value: editingAnswers.value,
                          onChanged: (value) => editingAnswers.value = value,
                        );
                    }
                  })(),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: question.questionType != QuestionType.select,
          child: Column(
            children: [
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SynchronizedButton.elevated(
                  onPressed: () async {
                    await _checkIsCorrectYourAnswer(
                        context, ref, editingAnswers.value);
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _checkIsCorrectYourAnswer(
    BuildContext context,
    WidgetRef ref,
    List<String> attemptAnswers,
  ) async {
    final isCorrect = ref.read(checkIsCorrectUseCaseProvider).call(
          question: question,
          attemptAnswers: attemptAnswers,
        );
    ref.read(answerEffectStateProvider.notifier).state = isCorrect;
    await ref
        .read(answerWorkbookStateProvider(QuestionsStateKey(
                location: question.rawQuestion.location,
                workbookId: question.rawQuestion.workbookId))
            .notifier)
        .updateAnswerStatus(question.rawQuestion, isCorrect);
    await ref
        .read(answerWorkbookStateProvider(QuestionsStateKey(
                location: question.rawQuestion.location,
                workbookId: question.rawQuestion.workbookId))
            .notifier)
        .onAnswered(
          isCorrect: isCorrect,
          attemptAnswers: attemptAnswers,
        );
  }
}

class _AnswerWriteQuestionContent extends HookWidget {
  const _AnswerWriteQuestionContent({required this.onChanged});

  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final answerController = useTextEditingController();
    return AppTextFormField(
      autofocus: true,
      controller: answerController,
      hintText: '答えを入力してください',
      labelText: '答え',
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
    );
  }
}

class _AnswerCompleteQuestionContent extends HookWidget {
  const _AnswerCompleteQuestionContent({
    required this.question,
    required this.onChanged,
  });

  final AnsweringQuestion question;
  final void Function(List<String>) onChanged;

  @override
  Widget build(BuildContext context) {
    final answerControllers = useState<List<TextEditingController>>(
      question.answers.map((text) => TextEditingController()).toList(),
    );

    return SeparatedColumn(
      children: answerControllers.value
          .mapIndexed(
            (index, answer) => AppTextFormField(
              autofocus: index == 0,
              controller: answerControllers.value[index],
              hintText: '${index + 1}つ目の答えを入力してください',
              labelText: '${index + 1}つ目の答え',
              textInputAction: TextInputAction.next,
              onChanged: (_) {
                onChanged(
                  answerControllers.value.map((e) => e.text).toList(),
                );
              },
            ),
          )
          .toList(),
      separatorBuilder: (context) => const SizedBox(height: 16),
    );
  }
}

class _AnswerSelectCompleteQuestionContent extends HookWidget {
  const _AnswerSelectCompleteQuestionContent({
    required this.question,
    required this.value,
    required this.onChanged,
  });

  final AnsweringQuestion question;
  final List<String> value;
  final void Function(List<String>) onChanged;

  @override
  Widget build(BuildContext context) {
    final choices = useMemoized(() => question.choices);
    return SeparatedColumn(
      children: choices
          .map(
            (text) => CheckboxListTile(
              title: Text(text),
              subtitle: value.contains(text) && question.isCheckAnswerOrder
                  ? Text((value.indexOf(text) + 1).toString())
                  : null,
              value: value.contains(text),
              onChanged: (newValue) {
                if (newValue != null) {
                  if (newValue) {
                    onChanged([...value, text]);
                  } else {
                    onChanged(
                      value.where((element) => element != text).toList(),
                    );
                  }
                }
              },
            ),
          )
          .toList(),
      separatorBuilder: (context) => const SizedBox(height: 16),
    );
  }
}

class _AnswerSelectQuestionContent extends HookWidget {
  const _AnswerSelectQuestionContent({
    required this.question,
    required this.onSelected,
  });

  final AnsweringQuestion question;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      children: (question.choices + ['わからない'])
          .map(
            (text) => ElevatedButton(
              onPressed: () => onSelected(text),
              child: Text(text),
            ),
          )
          .toList(),
      separatorBuilder: (context) => const SizedBox(height: 16),
    );
  }
}
