import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class WorkbookListItem extends StatelessWidget {
  const WorkbookListItem({
    super.key,
    required this.workbook,
    required this.onTap,
  });

  final Workbook workbook;
  final void Function(Workbook workbook) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.edit_document,
        color: workbook.color.displayColor(),
      ),
      title: Text(
        workbook.title,
        maxLines: 2,
      ),
      subtitle: Text(
        AppLocalizations.of(context)!.valueQuestionCount(
          workbook.questionCount,
        ),
      ),
      onTap: () => onTap(workbook),
      trailing: () {
        switch (workbook.location) {
          case AppDataLocation.local:
            return IconButton(
              onPressed: () => showAlertDialog(
                context: context,
                title: AppLocalizations.of(context)!.titleSync,
                content: AppLocalizations.of(context)!.messageAboutSync,
                positiveButtonText: AppLocalizations.of(context)!.buttonSync,
                onPositive: () {
                  //TODO: 問題集のアップロード
                },
              ),
              icon: const Icon(Icons.cloud_off_outlined),
            );
          case AppDataLocation.remoteOwned:
            return IconButton(
              onPressed: () => showAppSnackBar(
                context,
                AppLocalizations.of(context)!.messageAlreadySyncWorkbook,
              ),
              icon: const Icon(Icons.cloud_done_outlined),
            );
          default:
            const SizedBox.shrink();
        }
      }(),
    );
  }
}
