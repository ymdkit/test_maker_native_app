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

  static ColorTheme from(String value) {
    return ColorTheme.values.firstWhereOrNull((e) => e.value == value) ??
        ColorTheme.blue;
  }
}
