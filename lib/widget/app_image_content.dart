import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_maker_native_app/utils/app_image.dart';

class AppImageContent extends StatelessWidget {
  const AppImageContent({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final AppImage image;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return image.when(
      empty: () => const SizedBox.shrink(),
      local: (path) => File(path).existsSync()
          ? Image.file(
            File(path),
            width: width,
            height: height,
            fit: fit,
          )
          : const SizedBox.shrink(),
      fireStore: (ref) => _FireStoreImage(
        ref: ref,
        width: width,
        height: height,
        fit: fit,
      ),
      http: (url) => Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}

class _FireStoreImage extends HookWidget {
  const _FireStoreImage({
    required this.ref,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String ref;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final imageUrl = useState<String?>(null);

    useEffect(() {
      final storage = FirebaseStorage.instance;
      storage.ref(ref).getDownloadURL().then((value) {
        imageUrl.value = value;
      });
      return null;
    }, []);
    return imageUrl.value != null
        ? Image.network(
            imageUrl.value!,
            width: width,
            height: height,
            fit: fit,
          )
        : const SizedBox.shrink();
  }
}
