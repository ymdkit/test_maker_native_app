import 'package:collection/collection.dart';

enum ColorTheme {
  blue('blue'),
  red('red'),
  green('green'),
  orange('orange'),
  yellow('yellow'),
  pink('pink'),
  purple('purple'),
  teal('teal'),
  indigo('indigo'),
  brown('brown');

  final String value;

  const ColorTheme(this.value);

  // TODO(ymdkit): ローカライズ
  String displayString() {
    switch (this) {
      case ColorTheme.blue:
        return 'ブルー';
      case ColorTheme.red:
        return 'レッド';
      case ColorTheme.green:
        return 'グリーン';
      case ColorTheme.orange:
        return 'オレンジ';
      case ColorTheme.yellow:
        return 'イエロー';
      case ColorTheme.pink:
        return 'ピンク';
      case ColorTheme.purple:
        return 'パープル';
      case ColorTheme.teal:
        return 'ティール';
      case ColorTheme.indigo:
        return 'インディゴ';
      case ColorTheme.brown:
        return 'ブラウン';
    }
  }

  static ColorTheme from(String value) {
    return ColorTheme.values.firstWhereOrNull((e) => e.value == value) ??
        ColorTheme.blue;
  }
}
