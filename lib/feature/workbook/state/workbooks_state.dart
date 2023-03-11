import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/repository/question_repository.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/trash/state/deleted_workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/repository/workbook_repository.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/utils/app_async_state.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

typedef WorkbooksState = AppAsyncState<List<Workbook>>;

final workbooksProvider = StateNotifierProvider.autoDispose
    .family<WorkbooksStateNotifier, WorkbooksState, WorkbooksStateKey>(
  (ref, key) {
    final _ = ref.watch(accountStateProvider);
    return WorkbooksStateNotifier(
      ref: ref,
      folderId: key.folderId,
      workbookRepository: ref.watch(workbookRepositoryProvider(key.location)),
      onMutateWorkbookStream:
          ref.watch(onMutateWorkbookStreamProvider(key.location)),
      onMutateQuestionStream:
          ref.watch(onMutateQuestionStreamProvider(key.location)),
      onMutateDeletedWorkbookStream:
          ref.watch(onMutateDeletedWorkbookStreamProvider(key.location)),
    );
  },
);

class WorkbooksStateNotifier extends StateNotifier<WorkbooksState> {
  WorkbooksStateNotifier({
    required this.ref,
    required this.folderId,
    required this.workbookRepository,
    required this.onMutateWorkbookStream,
    required StreamController<Question> onMutateQuestionStream,
    required StreamController<Workbook> onMutateDeletedWorkbookStream,
  }) : super(const WorkbooksState.loading()) {
    setupWorkbooks();
    onMutateQuestionSubscription = onMutateQuestionStream.stream.listen(
      (question) => _syncWorkbook(question.workbookId),
    );
    onMutateDeletedWorkbookSubscription =
        onMutateDeletedWorkbookStream.stream.listen(
      (_) => setupWorkbooks(),
    );
  }

  final Ref ref;
  final String? folderId;
  final WorkbookRepository workbookRepository;
  final StreamController<Workbook> onMutateWorkbookStream;
  late final StreamSubscription<Question> onMutateQuestionSubscription;
  late final StreamSubscription<Workbook> onMutateDeletedWorkbookSubscription;

  Future<void> setupWorkbooks() async {
    state = const WorkbooksState.loading();
    final result = await workbookRepository.getWorkbooks(
      folderId: folderId,
    );
    result.match(
      (l) => state = WorkbooksState.failure(exception: l),
      (r) => mounted ? state = WorkbooksState.success(value: r) : null,
    );
  }

  Future<Either<AppException, Workbook>> addWorkbook({
    required String title,
    required AppThemeColor color,
    required String? folderId,
    required bool isPublic,
  }) async {
    final result = await workbookRepository
        .addWorkbook(
          title: title,
          color: color,
          folderId: folderId,
          isPublic: isPublic,
        )
        .run();

    return result.match(
      (l) => left(l),
      (r) {
        if (this.folderId == folderId && mounted) {
          state.maybeWhen(
            success: (workbooks) => state = WorkbooksState.success(
              value: [...workbooks, r],
            ),
            orElse: () {},
          );
        }
        onMutateWorkbookStream.sink.add(r);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> updateWorkbook({
    required Workbook currentWorkbook,
    required String title,
    required AppThemeColor color,
    required String? folderId,
  }) async {
    final updatedWorkbook = currentWorkbook.copyWith(
      title: title,
      color: color,
      folderId: folderId,
    );
    final result = await workbookRepository.updateWorkbook(updatedWorkbook);

    return result.match(
      (l) => left(l),
      (r) {
        if (this.folderId == folderId && mounted) {
          state.maybeWhen(
            success: (workbooks) => state = WorkbooksState.success(
              value: workbooks.map(
                (e) {
                  if (e.workbookId == updatedWorkbook.workbookId) {
                    return updatedWorkbook;
                  } else {
                    return e;
                  }
                },
              ).toList(),
            ),
            orElse: () {},
          );
        }
        onMutateWorkbookStream.sink.add(updatedWorkbook);
        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> deleteWorkbook(Workbook workbook) async {
    final result = await workbookRepository.deleteWorkbook(workbook).run();
    return result.match(
      (l) => left(l),
      (r) {
        state.maybeWhen(
          success: (workbooks) {
            state = WorkbooksState.success(
              value: workbooks
                  .where((e) => e.workbookId != workbook.workbookId)
                  .toList(),
            );
            onMutateWorkbookStream.sink.add(workbook);
          },
          orElse: () {},
        );

        return right(r);
      },
    );
  }

  Future<Either<AppException, void>> transferWorkbook({
    required Workbook sourceWorkbook,
    required AppDataLocation destination,
  }) async {
    final destWorkbookRepository = ref.read(
      workbookRepositoryProvider(destination),
    );
    final destQuestionRepository = ref.read(
      questionRepositoryProvider(destination),
    );
    final sourceQuestionRepository = ref.read(
      questionRepositoryProvider(sourceWorkbook.location),
    );

    return destWorkbookRepository
        .addWorkbook(
          title: sourceWorkbook.title,
          color: sourceWorkbook.color,
          folderId: null,
          isPublic: false,
        )
        .flatMap(
          (destWorkbook) => sourceQuestionRepository
              .getQuestions(sourceWorkbook.workbookId)
              .flatMap(
                (r) => TaskEither.right(
                  r
                      .map(
                        (e) => e.copyWith(
                          workbookId: destWorkbook.workbookId,
                          location: destination,
                        ),
                      )
                      .toList(),
                ),
              ),
        )
        .flatMap(
          (r) => destQuestionRepository.addQuestions(r),
        )
        .flatMap(
      (r) {
        ref
            .read(
              workbooksProvider(
                      WorkbooksStateKey(location: destination, folderId: null))
                  .notifier,
            )
            .setupWorkbooks();

        return TaskEither.right(r);
      },
    ).run();
  }

  Future<void> _syncWorkbook(String workbookId) async {
    final result = await workbookRepository.getWorkbook(workbookId: workbookId);
    result.match(
      (l) => state = WorkbooksState.failure(exception: l),
      (r) {
        state.maybeWhen(
          success: (workbooks) {
            state = WorkbooksState.success(
              value: workbooks.map(
                (e) {
                  if (e.workbookId == workbookId) {
                    return r;
                  } else {
                    return e;
                  }
                },
              ).toList(),
            );
          },
          orElse: () {},
        );
      },
    );
  }

  @override
  void dispose() {
    onMutateDeletedWorkbookSubscription.cancel();
    onMutateQuestionSubscription.cancel();
    super.dispose();
  }
}

final onMutateWorkbookStreamProvider =
    Provider.family<StreamController<Workbook>, AppDataLocation>(
  (ref, _) => StreamController<Workbook>.broadcast(),
);
