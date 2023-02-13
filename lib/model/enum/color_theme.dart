import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

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

  Color displayColor() {
    switch (this) {
      case ColorTheme.blue:
        return Colors.blue;
      case ColorTheme.red:
        return Colors.red;
      case ColorTheme.green:
        return Colors.green;
      case ColorTheme.orange:
        return Colors.orange;
      case ColorTheme.yellow:
        return Colors.yellow;
      case ColorTheme.pink:
        return Colors.pink;
      case ColorTheme.purple:
        return Colors.purple;
      case ColorTheme.teal:
        return Colors.teal;
      case ColorTheme.indigo:
        return Colors.indigo;
      case ColorTheme.brown:
        return Colors.brown;
    }
  }

  static ColorTheme from(String value) {
    return ColorTheme.values.firstWhereOrNull((e) => e.value == value) ??
        ColorTheme.blue;
  }

  static ColorTheme fromIndex(int index) {
    return ColorTheme.values.elementAtOrNull(index) ?? ColorTheme.blue;
  }
}
