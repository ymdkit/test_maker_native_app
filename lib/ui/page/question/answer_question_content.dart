import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/ui/widget/app_text_form_field.dart';
import 'package:test_maker_native_app/ui/widget/separated_flex.dart';

class AnswerQuestionContent extends HookWidget {
  const AnswerQuestionContent({
    super.key,
    required this.question,
    required this.onAnswered,
  });

  final Question question;
  final VoidCallback onAnswered;

  @override
  Widget build(BuildContext context) {
    final answerControllers = useState<List<TextEditingController>>(
      question.answers.map((text) => TextEditingController()).toList(),
    );

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
                  if (question.questionType.hasWrongChoices())
                    SeparatedColumn(
                      children: [
                        question.answers.firstOrNull ?? '',
                        ...question.wrongChoices,
                        'わからない',
                      ]
                          .map(
                            (text) => ElevatedButton(
                              onPressed: () => onAnswered(),
                              child: Text(text),
                            ),
                          )
                          .toList(),
                      separatorBuilder: (context) => const SizedBox(height: 16),
                    )
                  else
                    ...question.answers.mapIndexed(
                      (index, answer) => AppTextFormField(
                        autofocus: index == 0,
                        controller: answerControllers.value[index],
                        hintText: '答えを入力してください',
                        labelText: '答え',
                        textInputAction: TextInputAction.next,
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: ElevatedButton(
            onPressed: onAnswered,
            child: const Text('OK'),
          ),
        )
      ],
    );
  }
}
