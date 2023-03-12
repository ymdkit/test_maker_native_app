import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

Future<T?> showOperateSearchedWorkbookSheet<T>(
  BuildContext context,
  Workbook workbook,
) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _OperateSearchedWorkbookSheet(
        workbook: workbook,
      ),
    );

class _OperateSearchedWorkbookSheet extends HookConsumerWidget {
  const _OperateSearchedWorkbookSheet({
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppDraggableScrollableSheet(
      initialChildSize: 0.4,
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
              title: Text(AppLocalizations.of(context)!.buttonAnswer),
              onTap: () async {
                await context.router.pop();
                // ignore: use_build_context_synchronously
                await context.router.push(
                  AnswerWorkbookRoute(workbook: workbook),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: Text(AppLocalizations.of(context)!.buttonReport),
              onTap: () async {
                final title = AppLocalizations.of(context)!
                    .valueReportWorkbook(workbook.workbookId);

                final body = '${workbook.title} を通報する理由を以下に記載してください';
                const mailAddress = 'testmaker.contact@gmail.com';

                await launchUrl(
                    Uri.parse('mailto:$mailAddress?subject=$title&body=$body'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
