import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class FolderListItem extends StatelessWidget {
  const FolderListItem({
    super.key,
    required this.folder,
    required this.onTap,
  });

  final Folder folder;
  final void Function(Folder) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.folder,
        color: folder.color.displayColor(),
      ),
      title: Text(folder.title),
      subtitle: Text(
        AppLocalizations.of(context)!.valueWorkbookCount(
          folder.workbookCount,
        ),
      ),
      onTap: () => onTap(folder),
      trailing: () {
        switch (folder.location) {
          case AppDataLocation.local:
            return IconButton(
              onPressed: () => showAlertDialog(
                context: context,
                title: AppLocalizations.of(context)!.titleSync,
                content: AppLocalizations.of(context)!.messageAboutSync,
                positiveButtonText: AppLocalizations.of(context)!.buttonSync,
                onPositive: () {
                  //TODO: フォルダのアップロード
                },
              ),
              icon: const Icon(Icons.cloud_off_outlined),
            );
          case AppDataLocation.remoteOwned:
            return IconButton(
              onPressed: () => showAppSnackBar(
                context,
                AppLocalizations.of(context)!.messageAlreadySyncFolder,
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
