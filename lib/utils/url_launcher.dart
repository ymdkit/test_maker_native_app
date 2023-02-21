import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'url_launcher.g.dart';

@riverpod
UrlLauncher urlLauncher(UrlLauncherRef ref) => UrlLauncher();

class UrlLauncher {
  Future<void> launch(String urlString) {
    return ChromeSafariBrowser().open(
      url: Uri.parse(urlString),
    );
  }
}
