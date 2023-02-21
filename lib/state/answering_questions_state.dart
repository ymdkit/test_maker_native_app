import 'package:dartx/dartx.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/enum/answer_status.dart';
import 'package:test_maker_native_app/model/question.dart';
import 'package:test_maker_native_app/repository/question_repository.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';

final answeringQuestionsProvider =
    Provider.family.autoDispose<List<Question>, String>(
  (ref, workbookId) {
    final questionRepository = ref.watch(questionRepositoryProvider);
    final preferences = ref.watch(preferencesStateProvider);

    var questions = questionRepository.getQuestions(workbookId);

    if (preferences.isRandom) {
      questions = questions.shuffled();
    }

    if (preferences.isOnlyWrong) {
      questions =
          questions.where((e) => e.answerStatus == AnswerStatus.wrong).toList();
    }

    return questions;
  },
);
