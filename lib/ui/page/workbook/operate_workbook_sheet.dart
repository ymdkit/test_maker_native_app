import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';
import 'package:test_maker_native_app/ui/page/workbook/answer_workbook_setting_sheet.dart';
import 'package:test_maker_native_app/ui/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/ui/widget/app_modal_bottom_sheet.dart';
import 'package:test_maker_native_app/ui/widget/app_snack_bar.dart';

Future<T?> showOperateWorkbookSheet<T>(
  BuildContext context,
  Workbook workbook,
) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _OperateWorkbookSheet(
        workbook: workbook,
      ),
    );

class _OperateWorkbookSheet extends HookConsumerWidget {
  const _OperateWorkbookSheet({
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowAnswerSettingDialog = ref.watch(
      preferencesStateProvider
          .select((value) => value.isShowAnswerSettingDialog),
    );

    final isMounted = useIsMounted();

    return AppDraggableScrollableSheet(
      initialChildSize: 0.5,
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(workbook.title),
            ),
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: const Text('解答する'),
              onTap: () async {
                if (workbook.questionCount == 0) {
                  await showAlertDialog(
                      context: context,
                      title: '出題エラー',
                      content: '保存されている問題はありません。問題を作成してください',
                      onPositive: () {
                        context.router.pushAll(
                          [
                            WorkbookDetailsRoute(
                              folderId: workbook.folderId,
                              workbookId: workbook.workbookId,
                            ),
                            CreateQuestionRoute(
                              workbookId: workbook.workbookId,
                            )
                          ],
                        );
                      });
                } else {
                  if (isMounted()) {
                    if (isShowAnswerSettingDialog) {
                      // ignore: inference_failure_on_function_invocation, use_build_context_synchronously
                      await showAnswerWorkbookSettingSheet(
                        context: context,
                        onStart: () {
                          context.router.push(
                            AnswerWorkbookRoute(
                              folderId: workbook.folderId,
                              workbookId: workbook.workbookId,
                            ),
                          );
                        },
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      await context.router.push(
                        AnswerWorkbookRoute(
                          folderId: workbook.folderId,
                          workbookId: workbook.workbookId,
                        ),
                      );
                    }
                    // ignore: use_build_context_synchronously
                    await context.router.pop();
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('編集する'),
              onTap: () {
                context.router.push(
                  WorkbookDetailsRoute(
                    folderId: workbook.folderId,
                    workbookId: workbook.workbookId,
                  ),
                );
                context.router.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('削除する'),
              onTap: () => showAppSnackBar(context, '問題集の削除'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
