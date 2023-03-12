import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/answer/ui/answer_workbook_setting_sheet.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state.dart';
import 'package:test_maker_native_app/feature/workbook/state/workbooks_state_key.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';
import 'package:test_maker_native_app/utils/dynamic_link_creator.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

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
      initialChildSize: 0.6,
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                workbook.title,
                maxLines: 1,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.play_arrow),
              title: Text(
                AppLocalizations.of(context)!.buttonAnswer,
              ),
              onTap: () async {
                if (workbook.questionCount == 0) {
                  await showAlertDialog(
                      context: context,
                      title: '出題エラー',
                      content: '保存されている問題はありません。問題を作成してください',
                      onPositive: () {
                        context.router.pushAll(
                          [
                            CreateQuestionRoute(
                              location: workbook.location,
                              workbookId: workbook.workbookId,
                            )
                          ],
                        );
                        // ignore: use_build_context_synchronously
                        context.router.pop();
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
                              workbook: workbook,
                            ),
                          );
                        },
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      await context.router.push(
                        AnswerWorkbookRoute(
                          workbook: workbook,
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
              title: Text(
                AppLocalizations.of(context)!.buttonEdit,
              ),
              onTap: () {
                context.router.push(
                  WorkbookDetailsRoute(
                    folderId: workbook.folderId,
                    workbookId: workbook.workbookId,
                    location: workbook.location,
                  ),
                );
                context.router.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: Text(
                AppLocalizations.of(context)!.buttonShare,
              ),
              onTap: () async {
                if (workbook.location == AppDataLocation.local) {
                  {
                    await showAlertDialog(
                      context: context,
                      title: '共有エラー',
                      content: 'クラウド上にアップロードされていない問題集は共有できません。問題集をアップロードしてください',
                      positiveButtonText:
                          AppLocalizations.of(context)!.buttonUpload,
                      onPositive: () {
                        ref.read(accountStateProvider).maybeWhen(
                          authenticated: (user) async {
                            final notifier = ref.read(
                              workbooksProvider(
                                WorkbooksStateKey.from(workbook),
                              ).notifier,
                            );

                            final transferWorkbookResult =
                                await notifier.transferWorkbook(
                              sourceWorkbook: workbook,
                              destination: AppDataLocation.remoteOwned,
                            );

                            transferWorkbookResult.match(
                              (l) => showAppSnackBar(
                                  context, l.rawException.toString()),
                              (r) async {
                                final result =
                                    // ignore: use_build_context_synchronously
                                    await _createAndCopyWorkbookLink(context);
                                // ignore: use_build_context_synchronously
                                result.isRight() && await context.router.pop();
                              },
                            );
                          },
                          orElse: () {
                            context.router.push(
                              const SignInRoute(),
                            );
                          },
                        );
                      },
                    );
                    return;
                  }
                } else {
                  final result = await _createAndCopyWorkbookLink(context);
                  // ignore: use_build_context_synchronously
                  result.isRight() && await context.router.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Either<AppException, String>> _createAndCopyWorkbookLink(
      BuildContext context) async {
    final result = await DynamicLinkCreator.create(
      context,
      workbook.workbookId,
    ).run();

    result.match((l) => showAppSnackBar(context, l.message), (r) {
      Clipboard.setData(ClipboardData(text: r));
      showAppSnackBar(
        context,
        AppLocalizations.of(context)!.messageCopyLink,
      );
    });
    return result;
  }
}
