import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';

class QuestionListItem extends HookConsumerWidget {
  const QuestionListItem({
    super.key,
    required this.question,
    required this.onTap,
  });

  final Question question;
  final void Function(Question) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor =
        ref.watch(preferencesStateProvider.select((e) => e.themeColor));
    return ListTile(
      leading: () {
        switch (question.answerStatus) {
          case AnswerStatus.correct:
            return Icon(
              Icons.circle_outlined,
              color: themeColor.displayColor(),
            );
          case AnswerStatus.wrong:
            return const Icon(
              Icons.close,
              color: Colors.grey,
            );
          case AnswerStatus.unAnswered:
            return const Icon(
              Icons.question_answer,
            );
        }
      }(),
      title: Text(
        question.problem,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(question.answers.join(' '),
          maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: question.problemImageUrl != null &&
              File(question.problemImageUrl!).existsSync()
          ? Image.file(
              File(question.problemImageUrl!),
              fit: BoxFit.contain,
            )
          : null,
      onTap: () => onTap(question),
    );
  }
}
