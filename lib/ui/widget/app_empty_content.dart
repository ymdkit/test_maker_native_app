import 'package:flutter/material.dart';

class AppEmptyContent extends StatelessWidget {
  const AppEmptyContent({
    super.key,
    required this.icon,
    required this.text,
    required this.fallbackButtonText,
    required this.onPressedFallbackButton,
  });

  final IconData icon;
  final String text;
  final String fallbackButtonText;
  final VoidCallback onPressedFallbackButton;

  const AppEmptyContent.workbook({
    super.key,
    required this.onPressedFallbackButton,
  })  : icon = Icons.edit_document,
        text = '保存されている問題集はありません\n問題集を作成してください',
        fallbackButtonText = '問題集を作成する';

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
            OutlinedButton(
              onPressed: onPressedFallbackButton,
              child: Text(fallbackButtonText),
            )
          ],
        ),
      ),
    );
  }
}
