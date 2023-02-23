import 'package:flutter/material.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';

extension ThemeDataExt on ThemeData {
  ThemeData copyWithSharedTheme(AppThemeColor appThemeColor) => copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: appThemeColor.displayColor(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            elevation: 0,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: appThemeColor.displayColor(),
        ),
      );
}
