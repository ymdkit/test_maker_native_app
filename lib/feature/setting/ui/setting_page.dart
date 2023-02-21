import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/constants/web_url.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/answer/model/question_condition.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/utils/package_information.dart';
import 'package:test_maker_native_app/utils/url_launcher.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_color_picker_sheet.dart';
import 'package:test_maker_native_app/widget/app_picker_sheet.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesStateProvider);
    final preferencesNotifier = ref.watch(preferencesStateProvider.notifier);

    final packageInfo = ref.watch(packageInfoProvider);
    final urlLauncher = ref.watch(urlLauncherProvider);

    return AppAdWrapper(
      adUnitId: AppAdUnitId.settingBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnswerWorkbookSettings(
                  preferences: preferences,
                  preferencesNotifier: preferencesNotifier),
              const Divider(indent: 16, endIndent: 16),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AppSectionTitle(title: '外観設定'),
              ),
              ListTile(
                title: const Text('テーマカラー'),
                subtitle: Text(
                  preferences.themeColor.displayString(),
                ),
                onTap: () async => showAppColorPickerSheet(
                  context: context,
                  onChanged: (color) =>
                      preferencesNotifier.setThemeColor(color),
                ),
              ),
              const Divider(indent: 16, endIndent: 16),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AppSectionTitle(title: 'その他'),
              ),
              ListTile(
                title: const Text('ゴミ箱'),
                onTap: () => context.router.push(const TrashRoute()),
              ),
              // TODO: 広告削除
              ListTile(
                title: const Text('よくある質問'),
                onTap: () => urlLauncher.launch(WebUrl.faq),
              ),
              ListTile(
                title: const Text('お問い合わせ'),
                onTap: () => urlLauncher.launch(WebUrl.contact),
              ),
              ListTile(
                title: const Text('プライバシーポリシー'),
                onTap: () => urlLauncher.launch(WebUrl.privacyPolicy),
              ),
              ListTile(
                title: const Text('利用規約'),
                onTap: () => urlLauncher.launch(WebUrl.termsOfService),
              ),
              ListTile(
                title: const Text('このアプリについて'),
                subtitle: Text('バージョン: ${packageInfo.version}'),
                onLongPress: () {
                  if (kDebugMode) {
                    context.router.push(const DebugRoute());
                  }
                },
                onTap: () => showLicensePage(
                  context: context,
                  applicationName: packageInfo.appName,
                  applicationVersion: packageInfo.version,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerWorkbookSettings extends StatelessWidget {
  const AnswerWorkbookSettings({
    super.key,
    required this.preferences,
    required this.preferencesNotifier,
  });

  final PreferencesState preferences;
  final PreferencesStateNotifier preferencesNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: AppSectionTitle(title: '出題設定'),
        ),
        ListTile(
          title: const Text('出題範囲'),
          subtitle: Text(
            QuestionCondition.values
                .elementAtOrDefault(
                    preferences.questionCondition.index, QuestionCondition.all)
                .displayString(),
          ),
          onTap: () => showAppPickerSheet(
            context: context,
            title: '出題範囲',
            items: QuestionCondition.values
                .map(
                  (e) => PickerItem(label: e.displayString(), value: e),
                )
                .toList(),
            onChanged: (value) =>
                preferencesNotifier.setQuestionCondition(value),
          ),
        ),
        SwitchListTile(
          title: const Text('出題順をランダムにする'),
          value: preferences.isRandom,
          onChanged: (value) => preferencesNotifier.setRandom(value),
        ),
        SwitchListTile(
          title: const Text('問題文と解答を入れ替える'),
          value: preferences.isSwapProblemAndAnswer,
          onChanged: (value) =>
              preferencesNotifier.setSwapProblemAndAnswer(value),
        ),
        SwitchListTile(
          title: const Text('自己採点する'),
          value: preferences.isSelfScoring,
          onChanged: (value) => preferencesNotifier.setSelfScoring(value),
        ),
        SwitchListTile(
          title: const Text('正解時も解説を表示する'),
          value: preferences.isAlwaysShowExplanation,
          onChanged: (value) =>
              preferencesNotifier.setAlwaysShowExplanation(value),
        ),
        SwitchListTile(
          title: const Text('大文字と小文字を区別しない'),
          value: preferences.isCaseInsensitive,
          onChanged: (value) => preferencesNotifier.setCaseInsensitive(value),
        ),
        SwitchListTile(
          title: const Text('解答前に出題設定を確認する'),
          value: preferences.isShowAnswerSettingDialog,
          onChanged: (value) =>
              preferencesNotifier.setShowAnswerSettingDialog(value),
        ),
        ListTile(
          title: const Text('出題数'),
          subtitle: Text('${preferences.numberOfQuestions}問'),
          onTap: () => showAppPickerSheet(
            context: context,
            title: '出題数',
            items: const [
              10,
              20,
              30,
              40,
              50,
              60,
              70,
              80,
              90,
              100,
              150,
              200,
              300,
              500,
              1000
            ]
                .map(
                  (e) => PickerItem(label: '$e', value: e),
                )
                .toList(),
            onChanged: (value) =>
                preferencesNotifier.setNumberOfQuestions(value),
          ),
        ),
      ],
    );
  }
}
