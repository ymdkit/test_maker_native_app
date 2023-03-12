import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_maker_native_app/constants/app_data_location.dart';
import 'package:test_maker_native_app/utils/app_image.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';

Future<T?> showPickImageSheet<T>({
  required BuildContext context,
  required AppDataLocation location,
  required void Function(AppImage) onPicked,
  required void Function()? onDeleted,
}) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _PickImageSheet(
        location: location,
        onPicked: onPicked,
        onDeleted: onDeleted,
      ),
    );

class _PickImageSheet extends HookWidget {
  const _PickImageSheet({
    required this.location,
    required this.onPicked,
    required this.onDeleted,
  });

  final AppDataLocation location;
  final void Function(AppImage) onPicked;
  final void Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    final isPicking = useState(false);
    final isMounted = useIsMounted();
    return AppDraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.5,
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: isPicking.value
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('画像の設定中'),
                    ),
                  ),
                  SizedBox(height: 16),
                  CircularProgressIndicator(),
                ],
              )
            : Column(
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
                          isPicking.value = true;
                          final filePath = await _pickImage(
                            source: ImageSource.camera,
                            location: location,
                          );

                          if (isMounted()) {
                            isPicking.value = false;
                            // ignore: use_build_context_synchronously
                            await sheetContext.router.pop();
                          }
                          onPicked(filePath);
                        } on PlatformException catch (e) {
                          if (e.code == 'camera_access_denied') {
                            await showAlertDialog(
                              context: sheetContext,
                              title: '権限エラー',
                              content:
                                  'カメラへのアクセスが許可されていません。アプリの設定からアクセスを許可してください',
                              positiveButtonText:
                                  AppLocalizations.of(context)!.buttonPermit,
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
                        isPicking.value = true;
                        final filePath = await _pickImage(
                          source: ImageSource.gallery,
                          location: location,
                        );

                        if (isMounted()) {
                          isPicking.value = false;
                          // ignore: use_build_context_synchronously
                          await sheetContext.router.pop();
                        }
                        onPicked(filePath);
                      } on PlatformException catch (e) {
                        if (e.code == 'photo_access_denied') {
                          await showAlertDialog(
                            context: sheetContext,
                            title: '権限エラー',
                            content:
                                '端末内の画像へのアクセスが許可されていません。アプリの設定からアクセスを許可してください',
                            positiveButtonText:
                                AppLocalizations.of(context)!.buttonPermit,
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

  Future<AppImage> _pickImage({
    required ImageSource source,
    required AppDataLocation location,
  }) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
    );
    if (image == null) {
      return const AppImage.empty();
    }

    final imageFileName = image.name;

    switch (location) {
      case AppDataLocation.local:
        final appDocDir = await getApplicationDocumentsDirectory();
        final appDocPath = appDocDir.path;
        final filePath = '$appDocPath/$imageFileName';

        await image.saveTo(filePath);

        return AppImage.local(path: filePath);
      case AppDataLocation.remoteOwned:
        final storage = FirebaseStorage.instance;
        final userId = FirebaseAuth.instance.currentUser?.uid;

        if (userId == null) {
          return const AppImage.empty();
        }
        final ref = storage.ref().child('$userId/$imageFileName');
        final snapshot = await ref.putFile(File(image.path));

        final url = await snapshot.ref.getDownloadURL();

        return AppImage.http(url: url);
      case AppDataLocation.remoteShared:
        throw UnimplementedError();
    }
  }
}
