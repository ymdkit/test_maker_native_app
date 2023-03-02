import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';

Future<T?> showPickImageSheet<T>({
  required BuildContext context,
  required void Function(String?) onPicked,
  required void Function()? onDeleted,
}) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _PickImageSheet(
        onPicked: onPicked,
        onDeleted: onDeleted,
      ),
    );

class _PickImageSheet extends HookWidget {
  const _PickImageSheet({
    required this.onPicked,
    required this.onDeleted,
  });

  final void Function(String?) onPicked;
  final void Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    final isMounted = useIsMounted();
    return AppDraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('画像設定'),
            ),
            ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('カメラで撮影'),
                onTap: () async {
                  try {
                    final filePath = await _pickImage(
                      source: ImageSource.camera,
                    );
                    if (isMounted()) {
                      // ignore: use_build_context_synchronously
                      await sheetContext.router.pop();
                    }
                    onPicked(filePath);
                  } on PlatformException catch (e) {
                    if (e.code == 'camera_access_denied') {
                      await showAlertDialog(
                        context: sheetContext,
                        title: '権限エラー',
                        content: 'カメラへのアクセスが許可されていません。アプリの設定からアクセスを許可してください',
                        positiveButtonText: '許可する',
                        onPositive: () => openAppSettings(),
                      );
                    }
                  }
                }),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('ライブラリから選択'),
              onTap: () async {
                try {
                  final filePath = await _pickImage(
                    source: ImageSource.gallery,
                  );
                  if (isMounted()) {
                    // ignore: use_build_context_synchronously
                    await sheetContext.router.pop();
                  }
                  onPicked(filePath);
                } on PlatformException catch (e) {
                  if (e.code == 'photo_access_denied') {
                    await showAlertDialog(
                      context: sheetContext,
                      title: '権限エラー',
                      content: '端末内の画像へのアクセスが許可されていません。アプリの設定からアクセスを許可してください',
                      positiveButtonText: '許可する',
                      onPositive: () => openAppSettings(),
                    );
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('画像を削除'),
              onTap: () {
                showAlertDialog(
                  context: sheetContext,
                  title: '画像の削除',
                  content: '画像を削除してもよろしいですか？',
                  onPositive: () {
                    sheetContext.router.pop();
                    onDeleted?.call();
                  },
                  isDangerous: true,
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<String?> _pickImage({
    required ImageSource source,
  }) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
    );
    if (image == null) {
      return null;
    }

    final imageFileName = image.name;

    // find path
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final filePath = '$appDocPath/$imageFileName';

    // save imageFile in filePath
    await image.saveTo(filePath);

    return filePath;
  }
}
