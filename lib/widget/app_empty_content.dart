import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppEmptyContent extends StatelessWidget {
  const AppEmptyContent({
    super.key,
    required this.icon,
    required this.text,
    this.fallbackButtonText,
    this.onPressedFallbackButton,
  });

  final IconData icon;
  final String text;
  final String? fallbackButtonText;
  final VoidCallback? onPressedFallbackButton;

  AppEmptyContent.workbook({
    super.key,
    required BuildContext context,
    required this.onPressedFallbackButton,
  })  : icon = Icons.edit_document,
        text = AppLocalizations.of(context)!.messageNotExistsWorkbooks,
        fallbackButtonText = AppLocalizations.of(context)!.buttonCreateWorkbook;

  AppEmptyContent.question({
    super.key,
    required BuildContext context,
    required this.onPressedFallbackButton,
  })  : icon = Icons.edit,
        text = AppLocalizations.of(context)!.messageNotExistsQuestions,
        fallbackButtonText = AppLocalizations.of(context)!.buttonCreateQuestion;

  AppEmptyContent.search({
    required BuildContext context,
    super.key,
  })  : icon = Icons.search,
        text = AppLocalizations.of(context)!.messageNotExistsSearchResult,
        fallbackButtonText = null,
        onPressedFallbackButton = null;

  AppEmptyContent.groupNotAuthorized({
    super.key,
    required BuildContext context,
    required this.onPressedFallbackButton,
  })  : icon = Icons.group,
        text =
            AppLocalizations.of(context)!.messageRequireSignInForGroupFeature,
        fallbackButtonText = AppLocalizations.of(context)!.buttonSignIn;

  AppEmptyContent.group({
    super.key,
    required BuildContext context,
    required this.onPressedFallbackButton,
  })  : icon = Icons.group,
        text = AppLocalizations.of(context)!.messageNotExistsGroups,
        fallbackButtonText = AppLocalizations.of(context)!.buttonCreateGroup;

  AppEmptyContent.groupWorkbook({
    super.key,
    required BuildContext context,
    required this.onPressedFallbackButton,
  })  : icon = Icons.edit_document,
        text = AppLocalizations.of(context)!.messageNotExistsWorkbookInGroup,
        fallbackButtonText =
            AppLocalizations.of(context)!.buttonLinkWorkbookToGroup;

  AppEmptyContent.trash({
    required BuildContext context,
    super.key,
  })  : icon = Icons.delete,
        text = AppLocalizations.of(context)!.messageNotExistsContentsInTrash,
        fallbackButtonText = '',
        onPressedFallbackButton = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 96),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: onPressedFallbackButton != null,
              child: OutlinedButton(
                onPressed: onPressedFallbackButton,
                child: Text(fallbackButtonText ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
