import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
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

class _OperateWorkbookSheet extends StatelessWidget {
  const _OperateWorkbookSheet({
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context) {
    return AppDraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      builder: (context, scrollController) => SingleChildScrollView(
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
                onTap: () {
                  if (workbook.questionCount == 0) {
                    showAlertDialog(
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
                          context.router.pop();
                        });
                  } else {
                    context.router.push(
                      AnswerWorkbookRoute(
                        folderId: workbook.folderId,
                        workbookId: workbook.workbookId,
                      ),
                    );
                    context.router.pop();
                  }
                }),
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
