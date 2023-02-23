import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppErrorContent extends StatelessWidget {
  const AppErrorContent({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onPressedRetryButton,
  });

  factory AppErrorContent.serverError({AsyncCallback? onPressedRetryButton}) =>
      AppErrorContent(
        icon: const Icon(
          Icons.error_outline,
          size: 96,
        ),
        title: 'システムエラー',
        description: 'システムエラーが発生しました。\nしばらく時間を置いてから再度お試しください',
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
