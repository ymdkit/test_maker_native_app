import 'package:flutter/material.dart';

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

  const AppEmptyContent.workbook({
    super.key,
    required this.onPressedFallbackButton,
  })  : icon = Icons.edit_document,
        text = '保存されている問題集はありません\n問題集を作成してください',
        fallbackButtonText = '問題集を作成する';

  const AppEmptyContent.question({
    super.key,
    required this.onPressedFallbackButton,
  })  : icon = Icons.edit,
        text = '保存されている問題はありません\n問題を作成してください',
        fallbackButtonText = '問題を作成する';

  const AppEmptyContent.search({
    super.key,
  })  : icon = Icons.search,
        text = 'キーワードが一致する問題集はありません\n検索キーワードを変更してください',
        fallbackButtonText = null,
        onPressedFallbackButton = null;

  const AppEmptyContent.trash({
    super.key,
  })  : icon = Icons.delete,
        text = 'ゴミ箱の中は空です',
        fallbackButtonText = '問題を作成する',
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
