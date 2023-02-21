import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/model/enum/question_condition.dart';
import 'package:test_maker_native_app/ui/utils/shared_preference.dart';

part 'preferences_state.freezed.dart';

final preferencesStateProvider = StateNotifierProvider.autoDispose<
    PreferencesStateNotifier, PreferencesState>((ref) {
  return PreferencesStateNotifier(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
  );
});

class PreferencesStateNotifier extends StateNotifier<PreferencesState> {
  PreferencesStateNotifier({
    required this.sharedPreferences,
  }) : super(
          PreferencesState(
            isRandom:
                sharedPreferences.getBool(PreferenceKey.isRandom.name) ?? true,
            isSwapProblemAndAnswer: sharedPreferences
                    .getBool(PreferenceKey.isSwapProblemAndAnswer.name) ??
                false,
            questionCondition: QuestionCondition.values.elementAtOrDefault(
                sharedPreferences
                        .getInt(PreferenceKey.questionCondition.name) ??
                    0,
                QuestionCondition.all),
            isSelfScoring:
                sharedPreferences.getBool(PreferenceKey.isSelfScoring.name) ??
                    false,
            isAlwaysShowExplanation: sharedPreferences
                    .getBool(PreferenceKey.isAlwaysShowExplanation.name) ??
                false,
            isCaseInsensitive: sharedPreferences
                    .getBool(PreferenceKey.isCaseInsensitive.name) ??
                false,
            isShowAnswerSettingDialog: sharedPreferences
                    .getBool(PreferenceKey.isShowAnswerSettingDialog.name) ??
                true,
            numberOfQuestions: sharedPreferences
                    .getInt(PreferenceKey.numberOfQuestions.name) ??
                100,
            startPosition:
                sharedPreferences.getInt(PreferenceKey.startPosition.name) ?? 0,
            answerWorkbookCount: sharedPreferences
                    .getInt(PreferenceKey.answerWorkbookCount.name) ??
                0,
            themeColor:
                sharedPreferences.getInt(PreferenceKey.themeColor.name) ??
                    AppThemeColor.blue.index,
          ),
        );

  final SharedPreferences sharedPreferences;

  void setRandom(bool isRandom) {
    state = state.copyWith(isRandom: isRandom);
    sharedPreferences.setBool(PreferenceKey.isRandom.name, isRandom);
  }

  void setSwapProblemAndAnswer(bool isSwapProblemAndAnswer) {
    state = state.copyWith(isSwapProblemAndAnswer: isSwapProblemAndAnswer);
    sharedPreferences.setBool(
        PreferenceKey.isSwapProblemAndAnswer.name, isSwapProblemAndAnswer);
  }

  void setQuestionCondition(QuestionCondition questionCondition) {
    state = state.copyWith(questionCondition: questionCondition);
    sharedPreferences.setInt(
        PreferenceKey.questionCondition.name, questionCondition.index);
  }

  void setSelfScoring(bool isSelfScoring) {
    state = state.copyWith(isSelfScoring: isSelfScoring);
    sharedPreferences.setBool(PreferenceKey.isSelfScoring.name, isSelfScoring);
  }

  void setAlwaysShowExplanation(bool isAlwaysShowExplanation) {
    state = state.copyWith(isAlwaysShowExplanation: isAlwaysShowExplanation);
    sharedPreferences.setBool(
        PreferenceKey.isAlwaysShowExplanation.name, isAlwaysShowExplanation);
  }

  void setCaseInsensitive(bool isCaseInsensitive) {
    state = state.copyWith(isCaseInsensitive: isCaseInsensitive);
    sharedPreferences.setBool(
        PreferenceKey.isCaseInsensitive.name, isCaseInsensitive);
  }

  void setShowAnswerSettingDialog(bool isShowAnswerSettingDialog) {
    state =
        state.copyWith(isShowAnswerSettingDialog: isShowAnswerSettingDialog);
    sharedPreferences.setBool(PreferenceKey.isShowAnswerSettingDialog.name,
        isShowAnswerSettingDialog);
  }

  void setNumberOfQuestions(int numberOfQuestions) {
    state = state.copyWith(numberOfQuestions: numberOfQuestions);
    sharedPreferences.setInt(
        PreferenceKey.numberOfQuestions.name, numberOfQuestions);
  }

  void setStartPosition(int startPosition) {
    state = state.copyWith(startPosition: startPosition);
    sharedPreferences.setInt(PreferenceKey.startPosition.name, startPosition);
  }

  void setAnswerWorkbookCount(int answerWorkbookCount) {
    state = state.copyWith(answerWorkbookCount: answerWorkbookCount);
    sharedPreferences.setInt(
        PreferenceKey.answerWorkbookCount.name, answerWorkbookCount);
  }

  void setThemeColor(int themeColor) {
    state = state.copyWith(themeColor: themeColor);
    sharedPreferences.setInt(PreferenceKey.themeColor.name, themeColor);
  }
}

@freezed
class PreferencesState with _$PreferencesState {
  const factory PreferencesState({
    required bool isRandom,
    required bool isSwapProblemAndAnswer,
    required QuestionCondition questionCondition,
    required bool isSelfScoring,
    required bool isAlwaysShowExplanation,
    required bool isCaseInsensitive,
    required bool isShowAnswerSettingDialog,
    required int numberOfQuestions,
    required int startPosition,
    required int answerWorkbookCount,
    required int themeColor,
  }) = _PreferencesState;
}
