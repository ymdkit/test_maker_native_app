package jp.gr.java_conf.foobar.testmaker.service

import android.content.*
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "jp.gr.java_conf.foobar.testmaker.service/preferences"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getAllPreferences" -> {
                    val defaultPreferences = context.getSharedPreferences("jp.gr.java_conf.foobar.testmaker.service_preferences", Context.MODE_PRIVATE)
                    val isRandom = defaultPreferences.getBoolean("random", true)
                    val isSwapProblemAndAnswer = defaultPreferences.getBoolean("reverse", false)
                    val isSelfScoring = defaultPreferences.getBoolean("manual", false)
                    val isAlwaysShowExplanation = defaultPreferences.getBoolean("alwaysReview", false)
                    val isShowAnswerSettingDialog = defaultPreferences.getBoolean("show_setting_dialog", true)
                    val playCount = defaultPreferences.getInt("play_count", 0)
                    val themeColor = defaultPreferences.getString("theme_color", "blue")

                    val sharedPreferences: SharedPreferences = context.getSharedPreferences("question", Context.MODE_PRIVATE)
                    val isRemoveAds = sharedPreferences.getBoolean("isRemovedAd", false)
                    val isCaseInsensitive = sharedPreferences.getBoolean("isCaseInsensitive", false)
                     val questionCount = sharedPreferences.getInt("question_count", 100)

                    result.success(mapOf(
                        "isRandom" to isRandom,
                        "isSwapProblemAndAnswer" to isSwapProblemAndAnswer,
                        "isSelfScoring" to isSelfScoring,
                        "isAlwaysShowExplanation" to isAlwaysShowExplanation,
                        "questionCount" to questionCount,
                        "isShowAnswerSettingDialog" to isShowAnswerSettingDialog,
                        "playCount" to playCount,
                        "themeColor" to themeColor,
                        "isRemoveAds" to isRemoveAds,
                        "isCaseInsensitive" to isCaseInsensitive
                    ))
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
