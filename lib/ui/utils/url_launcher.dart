import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final urlLauncherProvider = Provider.autoDispose((_) => UrlLauncher());

class UrlLauncher {
  Future<void> launch(String urlString) {
    return ChromeSafariBrowser().open(
      url: Uri.parse(urlString),
    );
  }
}
