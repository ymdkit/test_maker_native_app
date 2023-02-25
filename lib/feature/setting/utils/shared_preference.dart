import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference.g.dart';

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) =>
    throw UnimplementedError(
      'shared preferences should be overridden in main()',
    );

enum PreferenceKey {
  //出題設定
  questionCondition('questionCondition'),
  isRandom('random'),
  isSwapProblemAndAnswer('reverse'),
  isSelfScoring('manual'),
  isAlwaysShowExplanation('alwaysReview'),
  isCaseInsensitive('isCaseInsensitive'),
  isShowAnswerSettingDialog('show_setting_dialog'),
  numberOfQuestions('question_count'),
  startPosition('start_position'),

  //外観
  themeColor('theme_color'),

  //その他
  answerWorkbookCount('play_count'),
  isRemovedAds('isRemovedAd');

  final String name;

  const PreferenceKey(this.name);
}
