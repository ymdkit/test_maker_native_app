import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_image.freezed.dart';

@freezed
class AppImage with _$AppImage {
  const AppImage._();

  const factory AppImage.empty() = AppImage_Empty;
  const factory AppImage.local({
    required String path,
  }) = AppImage_Local;
  const factory AppImage.fireStore({
    required String ref,
  }) = AppImage_FireStore;
  const factory AppImage.http({
    required String url,
  }) = AppImage_Http;

  String? toStringOrNull() => when(
        empty: () => null,
        local: (path) => path,
        fireStore: (ref) => ref,
        http: (url) => url,
      );

  factory AppImage.from(String? rawString) {
    if (rawString == null || rawString.isEmpty) {
      return const AppImage.empty();
    } else if (rawString.startsWith('http')) {
      return AppImage.http(url: rawString);
    } else if ('/'.allMatches(rawString).length == 1) {
      return AppImage.fireStore(ref: rawString);
    } else {
      return AppImage.local(path: rawString);
    }
  }
}
