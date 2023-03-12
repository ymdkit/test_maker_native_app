import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppErrorContent extends StatelessWidget {
  const AppErrorContent({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onPressedRetryButton,
  });

  factory AppErrorContent.serverError({
    required BuildContext context,
    AsyncCallback? onPressedRetryButton,
  }) =>
      AppErrorContent(
        icon: const Icon(
          Icons.error_outline,
          size: 96,
        ),
        title: AppLocalizations.of(context)!.titleSystemError,
        description: AppLocalizations.of(context)!.messageSystemError,
        onPressedRetryButton: onPressedRetryButton,
      );

  final Widget icon;
  final String title;
  final String description;
  final AsyncCallback? onPressedRetryButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 16),
            Text(title),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
