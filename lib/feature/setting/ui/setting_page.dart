import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:test_maker_native_app/constants/web_url.dart';
import 'package:test_maker_native_app/feature/account/state/account_state.dart';
import 'package:test_maker_native_app/feature/answer/model/question_condition.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';
import 'package:test_maker_native_app/utils/package_information.dart';
import 'package:test_maker_native_app/utils/url_launcher.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';
import 'package:test_maker_native_app/widget/app_alert_dialog.dart';
import 'package:test_maker_native_app/widget/app_color_picker_sheet.dart';
import 'package:test_maker_native_app/widget/app_picker_sheet.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';
import 'package:test_maker_native_app/widget/app_snack_bar.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesStateProvider);
    final preferencesNotifier = ref.watch(preferencesStateProvider.notifier);

    final packageInfo = ref.watch(packageInfoProvider);
    final urlLauncher = ref.watch(urlLauncherProvider);

    final account = ref.watch(accountStateProvider);

    final isMounted = useIsMounted();

    return AppAdWrapper(
      adUnitId: AppAdUnitId.settingBanner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.tabSetting,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnswerWorkbookSettings(
                  preferences: preferences,
                  preferencesNotifier: preferencesNotifier),
              const Divider(indent: 16, endIndent: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AppSectionTitle(
                  title: AppLocalizations.of(context)!.sectionSettingAppearance,
                ),
              ),
              ListTile(
                title: const Text('テーマカラー'),
                subtitle: Text(
                  preferences.themeColor.displayString(context),
                ),
                onTap: () async => showAppColorPickerSheet(
                  context: context,
                  onChanged: (color) =>
                      preferencesNotifier.setThemeColor(color),
                ),
              ),
              const Divider(indent: 16, endIndent: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AppSectionTitle(
                  title: AppLocalizations.of(context)!.sectionSettingAccount,
                ),
              ),
              ...account.maybeWhen(
                guest: () => [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.signIn),
                    onTap: () => context.router.push(const SignInRoute()),
                  )
                ],
                authenticated: (user) => [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.signOut),
                    onTap: () async {
                      await showAlertDialog(
                        context: context,
                        title: 'ログアウトの確認',
                        content: AppLocalizations.of(context)!.confirmSignOut,
                        isDangerous: true,
                        positiveButtonText:
                            AppLocalizations.of(context)!.buttonSignOut,
                        onPositive: () async {
                          await ref
                              .read(accountStateProvider.notifier)
                              .signOut();
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('退会'),
                    onTap: () async {
                      await showAlertDialog(
                        context: context,
                        title: '退会について',
                        content:
                            '''退会すると、クラウド上に同期した問題集にアクセスすることは不可能になります。こちらをご理解した上で次に進んでください。''',
                        isDangerous: true,
                        positiveButtonText: '次へ進む',
                        onPositive: () async {
                          await showAlertDialog(
                            context: context,
                            title: '退会の確認',
                            content: AppLocalizations.of(context)!
                                .confirmDeleteAccountExactly,
                            isDangerous: true,
                            onPositive: () async {
                              final result = await ref
                                  .read(accountStateProvider.notifier)
                                  .deleteAccount();

                              result.match(
                                (l) {
                                  switch (l.code) {
                                    case AppExceptionCode.unAuthorized:
                                      context.router.push(const SignInRoute());
                                      showAppSnackBar(
                                          context, 'この操作を行うには再ログインが必要です');
                                      break;
                                    default:
                                      showAppSnackBar(context, '退会に失敗しました');
                                  }
                                },
                                (r) => showAppSnackBar(context, '退会しました'),
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ],
                orElse: () => [const SizedBox.shrink()],
              ),
              const Divider(indent: 16, endIndent: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AppSectionTitle(
                    title: AppLocalizations.of(context)!.sectionSettingOther),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.trash),
                onTap: () => context.router.push(const TrashRoute()),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.removeAds),
                subtitle:
                    preferences.isRemovedAds ? const Text('広告削除済み') : null,
                onTap: () async {
                  if (preferences.isRemovedAds) {
                    showAppSnackBar(context, '広告削除済みです');
                    return;
                  }
                  try {
                    final offerings = await Purchases.getOfferings();
                    final offering = offerings.current;
                    final package = offering?.getPackage('removeAd');

                    if (package != null) {
                      final purchaseInfo =
                          await Purchases.purchasePackage(package);
                      final isRemovedAd =
                          purchaseInfo.entitlements.all['RemoveAd']?.isActive ??
                              false;
                      if (isRemovedAd) {
                        preferencesNotifier.setRemovedAds(true);
                      }
                    } else {
                      if (isMounted()) {
                        // ignore: use_build_context_synchronously
                        showAppSnackBar(context, '購入可能な商品が存在しません');
                      }
                      return;
                    }
                  } on PlatformException catch (e) {
                    final errorCode = PurchasesErrorHelper.getErrorCode(e);
                    if (errorCode !=
                        PurchasesErrorCode.purchaseCancelledError) {
                      showAppSnackBar(
                          context, '購入に失敗しました。しばらくお待ちの上、もう一度やり直してください');
                    }
                  }
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.restorePurchase),
                onTap: () async {
                  try {
                    final restoredInfo = await Purchases.restorePurchases();
                    final isRemovedAd =
                        restoredInfo.entitlements.all['RemoveAd']?.isActive ??
                            false;
                    if (isRemovedAd) {
                      // ignore: use_build_context_synchronously
                      showAppSnackBar(context, '購入情報を復元しました');
                      preferencesNotifier.setRemovedAds(isRemovedAd);
                    }
                  } on PlatformException {
                    showAppSnackBar(
                        context, '購入復元に失敗しました。しばらくお待ちの上、もう一度やり直してください');
                  }
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.faq),
                onTap: () => urlLauncher.launch(WebUrl.faq),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.contact),
                onTap: () => urlLauncher.launch(WebUrl.contact),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.privacyPolicy),
                onTap: () => urlLauncher.launch(WebUrl.privacyPolicy),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.termsOfService),
                onTap: () => urlLauncher.launch(WebUrl.termsOfService),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.aboutThisApp),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: AppSectionTitle(
              title: AppLocalizations.of(context)!.sectionSettingAnswer),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.answerSettingIsRandom),
          value: preferences.isRandom,
          onChanged: (value) => preferencesNotifier.setRandom(value),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!
              .answerSettingIsSwapProblemAndAnswer),
          value: preferences.isSwapProblemAndAnswer,
          onChanged: (value) =>
              preferencesNotifier.setSwapProblemAndAnswer(value),
        ),
        SwitchListTile(
          title: Text(AppLocalizations.of(context)!.answerSettingIsSelfScoring),
          value: preferences.isSelfScoring,
          onChanged: (value) => preferencesNotifier.setSelfScoring(value),
        ),
        SwitchListTile(
          title: Text(
            AppLocalizations.of(context)!.answerSettingIsAlwaysShowExplanation,
          ),
          value: preferences.isAlwaysShowExplanation,
          onChanged: (value) =>
              preferencesNotifier.setAlwaysShowExplanation(value),
        ),
        SwitchListTile(
          title: Text(
              AppLocalizations.of(context)!.answerSettingIsCaseInsensitive),
          value: preferences.isCaseInsensitive,
          onChanged: (value) => preferencesNotifier.setCaseInsensitive(value),
        ),
        SwitchListTile(
          title: Text(
              AppLocalizations.of(context)!.answerSettingIsShowSettingDialog),
          value: preferences.isShowAnswerSettingDialog,
          onChanged: (value) =>
              preferencesNotifier.setShowAnswerSettingDialog(value),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.answerSettingQuestionCondition,
          ),
          subtitle: Text(
            QuestionCondition.values
                .elementAtOrDefault(
                    preferences.questionCondition.index, QuestionCondition.all)
                .displayString(context),
          ),
          onTap: () => showAppPickerSheet(
            context: context,
            title: AppLocalizations.of(context)!.answerSettingQuestionCondition,
            items: QuestionCondition.values
                .map(
                  (e) => PickerItem(label: e.displayString(context), value: e),
                )
                .toList(),
            onChanged: (value) =>
                preferencesNotifier.setQuestionCondition(value),
          ),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.answerSettingLimit),
          subtitle: Text('${preferences.numberOfQuestions}問'),
          onTap: () => showAppPickerSheet(
            context: context,
            title: AppLocalizations.of(context)!.answerSettingLimit,
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
