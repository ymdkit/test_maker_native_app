import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppAdWidget extends HookWidget {
  const AppAdWidget({
    super.key,
    required this.adUnitId,
  });

  final String adUnitId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final banner = useMemoized(
      () => BannerAd(
        size: AdSize(width: screenWidth.toInt(), height: AdSize.banner.height),
        adUnitId:
            kDebugMode ? 'ca-app-pub-3940256099942544/6300978111' : adUnitId,
        listener: const BannerAdListener(),
        request: const AdRequest(),
      ),
    );

    useEffect(() {
      banner.load();
      return banner.dispose;
    }, const []);

    return SizedBox(
      height: AdSize.banner.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }
}

class AppAdUnitId {
  static String get homeBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidHomeBannerId')
      : const String.fromEnvironment('adMobIOSHomeBannerId');

  static String get createFolderBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidCreateFolderBannerId')
      : const String.fromEnvironment('adMobIOSCreateFolderBannerId');

  static String get folderDetailsBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidFolderDetailsBannerId')
      : const String.fromEnvironment('adMobIOSFolderDetailsBannerId');

  static String get editFolderBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidEditFolderBannerId')
      : const String.fromEnvironment('adMobIOSEditFolderBannerId');

  static String get createWorkbookBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidCreateWorkbookBannerId')
      : const String.fromEnvironment('adMobIOSCreateWorkbookBannerId');

  static String get editWorkbookBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidEditWorkbookBannerId')
      : const String.fromEnvironment('adMobIOSEditWorkbookBannerId');

  static String get workbookDetailsBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidWorkbookDetailsBannerId')
      : const String.fromEnvironment('adMobIOSWorkbookDetailsBannerId');

  static String get createQuestionBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidCreateQuestionBannerId')
      : const String.fromEnvironment('adMobIOSCreateQuestionBannerId');

  static String get editQuestionBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidEditQuestionBannerId')
      : const String.fromEnvironment('adMobIOSEditQuestionBannerId');

  static String get answerWorkbookBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidAnswerWorkbookBannerId')
      : const String.fromEnvironment('adMobIOSAnswerWorkbookBannerId');

  static String get answerResultWorkbookBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidAnswerResultWorkbookBannerId')
      : const String.fromEnvironment('adMobIOSAnswerResultWorkbookBannerId');

  static String get searchBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidSearchBannerId')
      : const String.fromEnvironment('adMobIOSSearchBannerId');

  static String get groupListBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidGroupListBannerId')
      : const String.fromEnvironment('adMobIOSGroupListBannerId');

  static String get createGroupBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidCreateGroupBannerId')
      : const String.fromEnvironment('adMobIOSCreateGroupBannerId');

  static String get groupDetailsBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidGroupDetailsBannerId')
      : const String.fromEnvironment('adMobIOSGroupDetailsBannerId');

  static String get editGroupBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidEditGroupBannerId')
      : const String.fromEnvironment('adMobIOSEditGroupBannerId');

  static String get recordBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidRecordBannerId')
      : const String.fromEnvironment('adMobIOSRecordBannerId');

  static String get settingBanner => Platform.isAndroid
      ? const String.fromEnvironment('adMobAndroidSettingBannerId')
      : const String.fromEnvironment('adMobIOSSettingBannerId');

}
