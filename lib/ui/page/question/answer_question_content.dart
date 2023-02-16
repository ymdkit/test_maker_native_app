import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_maker_native_app/model/enum/question_type.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';
import 'package:test_maker_native_app/ui/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/ui/widget/separated_flex.dart';

class AnswerQuestionForm extends HookWidget {
  const AnswerQuestionForm({
    super.key,
    required this.question,
    required this.onAnswered,
  });

  final Question question;
  final VoidCallback onAnswered;

  @override
  Widget build(BuildContext context) {
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
                  Text(question.problem),
                  const SizedBox(height: 16),
                  if (question.problemImageUrl != null)
                    Column(
                      children: [
                        Image.file(
                          File(question.problemImageUrl!),
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
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
                            _validateAnswer(context, editingAnswers.value);
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
                child: ElevatedButton(
                  onPressed: () {
                    _validateAnswer(context, editingAnswers.value);
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }

  void _validateAnswer(
    BuildContext context,
    List<String> answers,
  ) {
    showAppSnackBar(context, answers.join(' '));
    onAnswered();
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

  final Question question;
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

  final Question question;
  final List<String> value;
  final void Function(List<String>) onChanged;

  @override
  Widget build(BuildContext context) {
    final shuffledChoices = useMemoized(() => question.shuffledChoices);
    return SeparatedColumn(
      children: shuffledChoices
          .map(
            (text) => CheckboxListTile(
              title: Text(text),
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

  final Question question;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    final shuffledChoices =
        useMemoized(() => question.shuffledChoices + ['わからない']);

    return SeparatedColumn(
      children: shuffledChoices
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
