import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:test_maker_native_app/constants/magic_number.dart';
import 'package:test_maker_native_app/feature/answer/state/answer_workbook_state.dart';
import 'package:test_maker_native_app/feature/question/model/answer_status.dart';
import 'package:test_maker_native_app/feature/question/model/question.dart';
import 'package:test_maker_native_app/feature/question/state/questions_state_key.dart';
import 'package:test_maker_native_app/feature/question/ui/question_list_item.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/feature/setting/utils/shared_preference.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/widget/app_section_title.dart';

class AnswerWorkbookResultContent extends HookConsumerWidget {
  const AnswerWorkbookResultContent({
    super.key,
    required this.workbook,
    required this.answeringQuestions,
  });

  final Workbook workbook;
  final List<Question> answeringQuestions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(
      preferencesStateProvider.select((value) => value.themeColor),
    );

    final correctRate = answeringQuestions.isEmpty
        ? 0
        : answeringQuestions
                .where((q) => q.answerStatus == AnswerStatus.correct)
                .length /
            answeringQuestions.length;

    final wrongRate = 1 - correctRate;

    useEffect(() {
      () async {
        final currentAnswerCount = ref
                .read(sharedPreferencesProvider)
                .getInt(PreferenceKey.answerWorkbookCount.name) ??
            0;
        if (currentAnswerCount ==
            MagicNumber.requireAnswerCountForInAppReview) {
          final inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            await inAppReview.requestReview();
          }
        } else if (currentAnswerCount >=
            MagicNumber.requireAnswerCountForAppTrackingTransparency) {
          if (await AppTrackingTransparency.trackingAuthorizationStatus ==
              TrackingStatus.notDetermined) {
            await AppTrackingTransparency.requestTrackingAuthorization();
          }
        }
      }();
      return null;
    }, []);

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSectionTitle(
                        title:
                            AppLocalizations.of(context)!.sectionAnswerResult,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Row(
                          children: [
                            Visibility(
                              visible: correctRate > 0,
                              child: Expanded(
                                flex: (correctRate * 100).toInt(),
                                child: ColoredBox(
                                  color: themeColor.displayColor(),
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: wrongRate > 0,
                              child: Expanded(
                                flex: (wrongRate * 100).toInt(),
                                child: const ColoredBox(
                                  color: Colors.grey,
                                  child: SizedBox.expand(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .labelAnsweredCount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: '${answeringQuestions.length}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const WidgetSpan(
                                        child: SizedBox(width: 16)),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .labelCorrectCount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: '${answeringQuestions.where(
                                            (q) =>
                                                q.answerStatus ==
                                                AnswerStatus.correct,
                                          ).length}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const WidgetSpan(
                                        child: SizedBox(width: 16)),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .labelCorrectRate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: '${(correctRate * 100).toInt()}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: !workbook.isOwned,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                //TOOD: 問題集の複製
                              },
                              label: Text(
                                AppLocalizations.of(context)!
                                    .buttonCopyWorkbookForMe,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                    child: Divider(),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: AppSectionTitle(
                    title: AppLocalizations.of(context)!.question,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return QuestionListItem(
                      question: answeringQuestions[index],
                      onTap: (question) {
                        if (workbook.isOwned) {
                          context.router.push(
                            EditQuestionRoute(
                              workbookId: question.workbookId,
                              question: question,
                              location: workbook.location,
                            ),
                          );
                        }
                      },
                    );
                  },
                  childCount: answeringQuestions.length,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const Divider(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => ref
                        .read(answerWorkbookStateProvider(QuestionsStateKey(
                          location: workbook.location,
                          workbookId: workbook.workbookId,
                        )).notifier)
                        .reset(),
                    child: Text(
                      AppLocalizations.of(context)!.buttonRetry,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      context.router.replaceAll(
                        [const RootRoute()],
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.buttonBackToTop,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
