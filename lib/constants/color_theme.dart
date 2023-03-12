import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  String displayString(BuildContext context) {
    switch (this) {
      case AppThemeColor.blue:
        return AppLocalizations.of(context)!.colorBlue;
      case AppThemeColor.red:
        return AppLocalizations.of(context)!.colorRed;
      case AppThemeColor.green:
        return AppLocalizations.of(context)!.colorGreen;
      case AppThemeColor.orange:
        return AppLocalizations.of(context)!.colorOrange;
      case AppThemeColor.yellow:
        return AppLocalizations.of(context)!.colorYellow;
      case AppThemeColor.pink:
        return AppLocalizations.of(context)!.colorPink;
      case AppThemeColor.purple:
        return AppLocalizations.of(context)!.colorPurple;
      case AppThemeColor.teal:
        return AppLocalizations.of(context)!.colorTeal;
      case AppThemeColor.indigo:
        return AppLocalizations.of(context)!.colorIndigo;
      case AppThemeColor.brown:
        return AppLocalizations.of(context)!.colorBrown;
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

  static AppThemeColor fromAndroidPreference(String value) {
    return AppThemeColor.from(value.toLowerCase());
  }

  static AppThemeColor fromIndex(int index) {
    return AppThemeColor.values.elementAtOrNull(index) ?? AppThemeColor.blue;
  }
}
