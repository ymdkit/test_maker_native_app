import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

Future<T?> showOperateQuestionSheet<T>(
  BuildContext context,
  Question question,
) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _OperateWorkbookSheet(
        question: question,
      ),
    );

class _OperateWorkbookSheet extends HookConsumerWidget {
  const _OperateWorkbookSheet({
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                question.problem,
                maxLines: 1,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(AppLocalizations.of(context)!.buttonEdit),
              onTap: () {
                context.router.push(
                  EditQuestionRoute(
                    workbookId: question.workbookId,
                    question: question,
                    location: question.location,
                  ),
                );
                context.router.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: Text(AppLocalizations.of(context)!.buttonCopy),
              onTap: () {
                ref
                    .read(questionsProvider(QuestionsStateKey(
                      location: question.location,
                      workbookId: question.workbookId,
                    )).notifier)
                    .copyQuestion(question: question);
                context.router.pop();
                showAppSnackBar(
                  context,
                  AppLocalizations.of(context)!.messageCopyQuestionSuccess,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text(AppLocalizations.of(context)!.buttonDelete),
              onTap: () {
                showAlertDialog(
                  context: context,
                  title: AppLocalizations.of(context)!.titleDeleteQuestion,
                  content: AppLocalizations.of(context)!.confirmDeleteQuestion,
                  positiveButtonText:
                      AppLocalizations.of(context)!.buttonDelete,
                  isDangerous: true,
                  onPositive: () {
                    context.router.pop();
                    ref
                        .read(questionsProvider(QuestionsStateKey(
                          location: question.location,
                          workbookId: question.workbookId,
                        )).notifier)
                        .deleteQuestion(question);
                    showAppSnackBar(
                      context,
                      AppLocalizations.of(context)!
                          .messageDeleteQuestionSuccess,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
