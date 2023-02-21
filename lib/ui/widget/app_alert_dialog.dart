import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? positiveButtonText,
  required void Function() onPositive,
  String? negativeButtonText,
  void Function()? onNegative,
  bool isDangerous = false,
}) async =>
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(
              negativeButtonText ?? 'キャンセル',
            ),
            onPressed: () async {
              await dialogContext.router.pop();
              onNegative?.call();
            },
          ),
          TextButton(
            child: Text(positiveButtonText ?? 'OK',
                style: isDangerous ? const TextStyle(color: Colors.red) : null),
            onPressed: () async {
              await dialogContext.router.pop();
              onPositive();
            },
          ),
        ],
      ),
    );
