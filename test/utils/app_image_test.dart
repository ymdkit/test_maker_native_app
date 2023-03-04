import 'package:flutter_test/flutter_test.dart';
import 'package:test_maker_native_app/utils/app_image.dart';

void main() {
  test('AppImage.http が 作成されること', () {
    const rawString =
        'https://firebasestorage.googleapis.com/v0/b/project-name/o/xxxxxxx';

    final actual = AppImage.from(rawString);

    expect(actual, isA<AppImage_Http>());
    expect(actual, const AppImage.http(url: rawString));
  });

  test('AppImage.fireStore が 作成されること', () {
    const rawString = 'xxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxx';

    final actual = AppImage.from(rawString);

    expect(actual, isA<AppImage_FireStore>());
    expect(actual, const AppImage.fireStore(ref: rawString));
  });

  test('AppImage.local が 作成されること', () {
    const rawString =
        '/var/mobile/Containers/Data/Application/D835F012-7095-40A8-9CA2-F626A8177FA4/Documents/image_picker_AE7DD59D-711F-4CF5-84A2-B8521C9A0786-64900-00001255DCE8A1A0.jpg';

    final actual = AppImage.from(rawString);

    expect(actual, isA<AppImage_Local>());
    expect(actual, const AppImage.local(path: rawString));
  });

  test('AppImage.empty が 作成されること', () {
    final actual = AppImage.from('');

    expect(actual, isA<AppImage_Empty>());
    expect(actual, const AppImage.empty());
  });
  test('AppImage.empty が 作成されること', () {
    final actual = AppImage.from(null);

    expect(actual, isA<AppImage_Empty>());
    expect(actual, const AppImage.empty());
  });
}
