import 'package:flutter/material.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/utils/app_image.dart';
import 'package:test_maker_native_app/widget/app_image_content.dart';
import 'package:test_maker_native_app/widget/pick_image_sheet.dart';

class AppPickImageButton extends StatelessWidget {
  const AppPickImageButton({
    super.key,
    required this.image,
    required this.onPicked,
    required this.location,
  });

  final AppImage image;
  final ValueChanged<AppImage> onPicked;
  final AppDataLocation location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != const AppImage.empty())
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () async => showPickImageSheet(
                context: context,
                onPicked: onPicked,
                onDeleted: () => onPicked(const AppImage.empty()),
                location: location,
              ),
              child: AppImageContent(
                image: image,
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
              onDeleted: () => onPicked(const AppImage.empty()),
              location: location,
            ),
            label: const Text('画像を設定'),
            icon: const Icon(Icons.photo),
          ),
      ],
    );
  }
}
