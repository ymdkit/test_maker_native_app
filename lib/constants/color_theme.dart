import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum AppThemeColor {
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

  const AppThemeColor(this.value);

  // TODO(ymdkit): ローカライズ
  String displayString() {
    switch (this) {
      case AppThemeColor.blue:
        return 'ブルー';
      case AppThemeColor.red:
        return 'レッド';
      case AppThemeColor.green:
        return 'グリーン';
      case AppThemeColor.orange:
        return 'オレンジ';
      case AppThemeColor.yellow:
        return 'イエロー';
      case AppThemeColor.pink:
        return 'ピンク';
      case AppThemeColor.purple:
        return 'パープル';
      case AppThemeColor.teal:
        return 'ティール';
      case AppThemeColor.indigo:
        return 'インディゴ';
      case AppThemeColor.brown:
        return 'ブラウン';
    }
  }

  Color displayColor() {
    switch (this) {
      case AppThemeColor.blue:
        return Colors.blue;
      case AppThemeColor.red:
        return Colors.red;
      case AppThemeColor.green:
        return Colors.green;
      case AppThemeColor.orange:
        return Colors.orange;
      case AppThemeColor.yellow:
        return Colors.yellow;
      case AppThemeColor.pink:
        return Colors.pink;
      case AppThemeColor.purple:
        return Colors.purple;
      case AppThemeColor.teal:
        return Colors.teal;
      case AppThemeColor.indigo:
        return Colors.indigo;
      case AppThemeColor.brown:
        return Colors.brown;
    }
  }

  static AppThemeColor from(String value) {
    return AppThemeColor.values.firstWhereOrNull((e) => e.value == value) ??
        AppThemeColor.blue;
  }

  static AppThemeColor fromIndex(int index) {
    return AppThemeColor.values.elementAtOrNull(index) ?? AppThemeColor.blue;
  }
}
