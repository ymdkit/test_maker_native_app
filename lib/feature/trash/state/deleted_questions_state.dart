import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';

final deletedQuestionsProvider =
    StateNotifierProvider.autoDispose<QuestionsStateNotifier, List<Question>>(
  (ref) => QuestionsStateNotifier(
    questionRepository: ref.watch(questionRepositoryProvider),
    onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    onMutateDeletedQuestionStream:
        ref.watch(onMutateDeletedQuestionStreamProvider),
  ),
);

class QuestionsStateNotifier extends StateNotifier<List<Question>> {
  QuestionsStateNotifier({
    required this.questionRepository,
    required this.onMutateDeletedQuestionStream,
    required StreamController<Question> onMutateQuestionStream,
  }) : super(questionRepository.getDeletedQuestions()) {
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) => state = questionRepository.getDeletedQuestions(),
    );
  }

  final QuestionRepository questionRepository;
  final StreamController<Question> onMutateDeletedQuestionStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;

  void restoreQuestion(Question question) {
    questionRepository.restoreQuestion(question);
    state = state.where((e) => e.questionId != question.questionId).toList();
    onMutateDeletedQuestionStream.sink.add(question);
  }

  void destroyQuestions() {
    questionRepository.destroyQuestions(state);
    state = [];
  }

  @override
  void dispose() {
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateDeletedQuestionStreamProvider = Provider(
  (ref) => StreamController<Question>.broadcast(),
);
