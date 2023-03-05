import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/feature/setting/utils/shared_preference.dart';

class PreferenceMigrator {
  static Future<void> migrate(
    SharedPreferences pref,
  ) async {
    if (pref.getBool(PreferenceKey.preferenceAlreadyMigrated.name) ?? false) {
      return;
    }

    const methodChannel =
        MethodChannel('jp.gr.java_conf.foobar.testmaker.service/preferences');

    final preferences = await methodChannel.invokeMapMethod<String, dynamic>(
      'getAllPreferences',
    );

    final migratedIsRandom = preferences?.getOrElse('isRandom', () => true);
    await pref.setBool(
      PreferenceKey.isRandom.name,
      migratedIsRandom as bool,
    );

    final migratedIsSwapProblemAndAnswer =
        preferences?.getOrElse('isSwapProblemAndAnswer', () => false);
    await pref.setBool(
      PreferenceKey.isSwapProblemAndAnswer.name,
      migratedIsSwapProblemAndAnswer as bool,
    );

    final isSelfScoring = preferences?.getOrElse('isSelfScoring', () => false);
    await pref.setBool(
      PreferenceKey.isSelfScoring.name,
      isSelfScoring as bool,
    );

    final isAlwaysShowExplanation = preferences?.getOrElse(
      'isAlwaysShowExplanation',
      () => false,
    );
    await pref.setBool(
      PreferenceKey.isAlwaysShowExplanation.name,
      isAlwaysShowExplanation as bool,
    );

    final questionCount = preferences?.getOrElse('questionCount', () => 10);
    await pref.setInt(
      PreferenceKey.numberOfQuestions.name,
      questionCount as int,
    );

    final isShowAnswerSettingDialog = preferences?.getOrElse(
      'isShowAnswerSettingDialog',
      () => true,
    );
    await pref.setBool(
      PreferenceKey.isShowAnswerSettingDialog.name,
      isShowAnswerSettingDialog as bool,
    );

    final playCount = preferences?.getOrElse('playCount', () => 0);
    await pref.setInt(
      PreferenceKey.answerWorkbookCount.name,
      playCount as int,
    );

    if (Platform.isAndroid) {
      final themeColor = preferences?.getOrElse('themeColor', () => 'blue');
      await pref.setInt(PreferenceKey.themeColor.name,
          AppThemeColor.fromAndroidPreference(themeColor as String).index);
    } else {
      final themeColor = preferences?.getOrElse('themeColor', () => 0);
      await pref.setInt(
        PreferenceKey.themeColor.name,
        themeColor as int,
      );
    }

    final isRemovedAds = preferences?.getOrElse('isRemovedAds', () => false);
    await pref.setBool(
      PreferenceKey.isRemovedAds.name,
      isRemovedAds as bool,
    );

    final isCaseInsensitive =
        preferences?.getOrElse('isCaseInsensitive', () => false);
    await pref.setBool(
      PreferenceKey.isCaseInsensitive.name,
      isCaseInsensitive as bool,
    );

    final questionCondition =
        preferences?.getOrElse('questionCondition', () => 0);
    await pref.setInt(
      PreferenceKey.questionCondition.name,
      questionCondition as int,
    );

    await pref.setBool(PreferenceKey.preferenceAlreadyMigrated.name, true);
  }
}
