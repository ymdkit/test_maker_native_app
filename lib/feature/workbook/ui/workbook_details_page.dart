import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/question/ui/operate_question_sheet.dart';
import 'package:test_maker_native_app/feature/question/ui/question_list_item.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbook_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/feature/workbook/usecase/export_workbook_use_case.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/utils/list_ext.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_empty_content.dart';
import 'package:test_maker_native_app/widget/app_error_content.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_sliver_space.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class WorkbookDetailsPage extends HookConsumerWidget {
  const WorkbookDetailsPage({
    super.key,
    required this.folderId,
    required this.workbookId,
    required this.location,
  });

  final String? folderId;
  final String workbookId;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbook = ref.watch(
      workbookProvider(
        key: WorkbooksStateKey(
          location: location,
          folderId: folderId,
        ),
        workbookId: workbookId,
      ),
    );
    final questionsState = ref.watch(questionsProvider(QuestionsStateKey(
      location: workbook.location,
      workbookId: workbookId,
    )));

    final isSearching = useState(false);
    final queryController = useTextEditingController();

    final isSelecting = useState(false);
    final selectedQuestions = useState(<Question>[]);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.workbookDetailsBanner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !isSearching.value,
          title: isSearching.value
              ? TextField(
                  autofocus: true,
                  controller: queryController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: AppLocalizations.of(context)!.hintSearch,
                    border: InputBorder.none,
                  ),
                  onSubmitted: (query) =>
                      ref.read(questionsQueryProvider.notifier).state = query,
                )
              : Text(workbook.title),
          actions: [
            ...isSelecting.value
                ? [
                    IconButton(
                      onPressed: () {
                        if (selectedQuestions.value.isEmpty) {
                          showAppSnackBar(context, '選択されていません');
                          return;
                        }
                        context.router.push(
                          SelectWorkbookRoute(
                            location: location,
                            title: '移動先の問題集を選択',
                            onSelected: (selectedWorkbook) async {
                              final result = await ref
                                  .read(
                                    questionsProvider(
                                      QuestionsStateKey(
                                        location: workbook.location,
                                        workbookId: workbookId,
                                      ),
                                    ).notifier,
                                  )
                                  .moveQuestions(
                                    destWorkbookId: selectedWorkbook.workbookId,
                                    questions: selectedQuestions.value,
                                  );

                              result.match(
                                (l) => showAppSnackBar(
                                  context,
                                  l.message,
                                ),
                                (success) {
                                  showAppSnackBar(
                                    context,
                                    '選択した問題を移動しました',
                                  );
                                  isSelecting.value = false;
                                  selectedQuestions.value = [];
                                },
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.move_to_inbox),
                    ),
                    IconButton(
                      onPressed: () {
                        if (selectedQuestions.value.isEmpty) {
                          showAppSnackBar(context, '選択されていません');
                          return;
                        }
                        context.router.push(
                          SelectWorkbookRoute(
                            location: location,
                            title: 'コピー先の問題集を選択',
                            onSelected: (selectedWorkbook) async {
                              final result = await ref
                                  .read(
                                    questionsProvider(
                                      QuestionsStateKey(
                                        location: workbook.location,
                                        workbookId: workbookId,
                                      ),
                                    ).notifier,
                                  )
                                  .copyQuestions(
                                    destWorkbookId: selectedWorkbook.workbookId,
                                    questions: selectedQuestions.value,
                                  );

                              result.match(
                                (l) => showAppSnackBar(
                                  context,
                                  l.message,
                                ),
                                (success) {
                                  showAppSnackBar(
                                    context,
                                    '選択した問題をコピーしました',
                                  );
                                  isSelecting.value = false;
                                  selectedQuestions.value = [];
                                },
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                    IconButton(
                      onPressed: () {
                        if (selectedQuestions.value.isEmpty) {
                          showAppSnackBar(context, '選択されていません');
                          return;
                        }
                        showAlertDialog(
                          context: context,
                          title: '選択した問題を削除',
                          content: '選択した問題を削除しますか？',
                          isDangerous: true,
                          positiveButtonText: '削除する',
                          onPositive: () async {
                            final result = await ref
                                .read(
                                  questionsProvider(
                                    QuestionsStateKey(
                                      location: workbook.location,
                                      workbookId: workbookId,
                                    ),
                                  ).notifier,
                                )
                                .deleteQuestions(
                                  selectedQuestions.value,
                                );

                            result.match(
                              (l) => showAppSnackBar(
                                context,
                                l.message,
                              ),
                              (success) {
                                showAppSnackBar(context, '問題を削除しました');
                                isSelecting.value = false;
                                selectedQuestions.value = [];
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        isSelecting.value = !isSelecting.value;
                        selectedQuestions.value = [];
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ]
                : [
                    IconButton(
                      onPressed: () {
                        isSearching.value = !isSearching.value;
                        if (!isSearching.value) {
                          queryController.clear();
                          ref.read(questionsQueryProvider.notifier).state = '';
                        }
                      },
                      icon: Icon(
                        isSearching.value ? Icons.close : Icons.search,
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: _PopupMenuItems.select,
                          child: Text('まとめて選択'),
                        ),
                        const PopupMenuItem(
                          value: _PopupMenuItems.edit,
                          child: Text('問題集の編集'),
                        ),
                        const PopupMenuItem(
                          value: _PopupMenuItems.export,
                          child: Text('問題集のエクスポート'),
                        ),
                        const PopupMenuItem(
                          value: _PopupMenuItems.delete,
                          child: Text('問題集の削除'),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case _PopupMenuItems.select:
                            isSelecting.value = !isSelecting.value;
                            break;
                          case _PopupMenuItems.edit:
                            context.router.push(
                              EditWorkbookRoute(workbook: workbook),
                            );
                            break;
                          case _PopupMenuItems.export:
                            () async {
                              final result = await ref
                                  .read(exportWorkbookUseCaseProvider)
                                  .call(
                                    workbook: workbook,
                                    questions: questionsState.maybeWhen(
                                      success: (data) => data,
                                      orElse: () => [],
                                    ),
                                  );

                              result.match(
                                (l) => showAppSnackBar(
                                  context,
                                  l.message,
                                ),
                                (text) async {
                                  final file = File(
                                    '${(await getTemporaryDirectory()).path}/${workbook.title}.csv',
                                  );
                                  await file.writeAsString(text);
                                  await Share.shareXFiles(
                                    [XFile(file.path)],
                                  );

                                  return null;
                                },
                              );
                            }();
                            break;
                          case _PopupMenuItems.delete:
                            showAlertDialog(
                              context: context,
                              title: '問題集の削除',
                              content: 'この問題集を削除しますか？',
                              isDangerous: true,
                              positiveButtonText: '削除する',
                              onPositive: () async {
                                final result = await ref
                                    .read(
                                      workbooksProvider(
                                              WorkbooksStateKey.from(workbook))
                                          .notifier,
                                    )
                                    .deleteWorkbook(workbook);

                                result.match(
                                  (l) => showAppSnackBar(
                                    context,
                                    l.message,
                                  ),
                                  (success) {
                                    showAppSnackBar(context, '問題集をゴミ箱に移動しました');
                                    context.router.pop();
                                  },
                                );
                              },
                            );
                            break;
                        }
                      },
                    ),
                  ]
          ],
        ),
        body: questionsState.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          success: (questions) => questions.isEmpty
              ? AppEmptyContent.question(
                  onPressedFallbackButton: () => context.router.push(
                    CreateQuestionRoute(
                      location: location,
                      workbookId: workbook.workbookId,
                    ),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    const AppSliverSpace(height: 16),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: AppSectionTitle(
                            title: AppLocalizations.of(context)!.question),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => QuestionListItem(
                          leading: isSelecting.value
                              ? Checkbox(
                                  value: selectedQuestions.value
                                      .contains(questions[index]),
                                  onChanged: (value) =>
                                      selectedQuestions.value =
                                          selectedQuestions.value
                                              .toggled(questions[index]),
                                )
                              : null,
                          question: questions[index],
                          onTap: (question) async {
                            if (isSelecting.value) {
                              selectedQuestions.value =
                                  selectedQuestions.value.toggled(question);
                            } else {
                              await showOperateQuestionSheet<void>(
                                context,
                                question,
                              );
                            }
                          },
                        ),
                        childCount: questions.length,
                      ),
                    ),
                  ],
                ),
          failure: (e) => AppErrorContent.serverError(),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'createQuestion',
          onPressed: () => context.router.push(
            CreateQuestionRoute(
              location: workbook.location,
              workbookId: workbook.workbookId,
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

enum _PopupMenuItems {
  select,
  edit,
  export,
  delete,
}
