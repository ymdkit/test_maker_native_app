import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

final deletedQuestionsProvider = StateNotifierProvider.autoDispose<
    DeletedQuestionsStateNotifier, QuestionsState>(
  (ref) => DeletedQuestionsStateNotifier(
    questionRepository: ref.watch(questionRepositoryProvider),
    onMutateQuestionStream: ref.watch(onMutateQuestionStreamProvider),
    onMutateDeletedQuestionStream:
        ref.watch(onMutateDeletedQuestionStreamProvider),
  ),
);

class DeletedQuestionsStateNotifier extends StateNotifier<QuestionsState> {
  DeletedQuestionsStateNotifier({
    required this.questionRepository,
    required StreamController<Question> onMutateQuestionStream,
    required this.onMutateDeletedQuestionStream,
  }) : super(const QuestionsState.loading()) {
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) async {
        final result = await questionRepository.getDeletedQuestions();
        result.match(
          (l) => state = QuestionsState.failure(exception: l),
          (r) => state = QuestionsState.success(value: r),
        );
      },
    );
  }

  final QuestionRepository questionRepository;
  final StreamController<Question> onMutateDeletedQuestionStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;

  Future<Either<AppException, void>> restoreQuestion(Question question) async =>
      await state.maybeWhen(
        success: (questions) async {
          final result = await questionRepository.restoreQuestion(question);

          return result.match(
            (l) => left(l),
            (r) {
              state = QuestionsState.success(
                value: questions
                    .where(
                      (e) => e.questionId != question.questionId,
                    )
                    .toList(),
              );
              return right(r);
            },
          );
        },
        orElse: () => right(null),
      );

  Future<Either<AppException, void>> destroyQuestions() async =>
      await state.maybeWhen(
        success: (questions) async {
          final result = await questionRepository.destroyQuestions(questions);

          return result.match(
            (l) => left(l),
            (r) {
              state = const QuestionsState.success(value: []);
              return right(r);
            },
          );
        },
        orElse: () => right(null),
      );

  @override
  void dispose() {
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateDeletedQuestionStreamProvider = Provider(
  (ref) => StreamController<Question>.broadcast(),
);
