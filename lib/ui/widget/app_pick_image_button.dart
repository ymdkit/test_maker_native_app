import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_maker_native_app/ui/page/question/pick_image_sheet.dart';

class AppPickImageButton extends StatelessWidget {
  const AppPickImageButton({
    super.key,
    required this.imageUrl,
    required this.onPicked,
  });

  final String? imageUrl;
  final ValueChanged<String?> onPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () async => showPickImageSheet(
                context: context,
                onPicked: onPicked,
                onDeleted: () => onPicked(null),
              ),
              child: Image.file(
                File(imageUrl!),
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          TextButton.icon(
            onPressed: () async => showPickImageSheet(
              context: context,
              onPicked: onPicked,
              onDeleted: () => onPicked(null),
            ),
            label: const Text('画像を設定'),
            icon: const Icon(Icons.photo),
          ),
      ],
    );
  }
}
