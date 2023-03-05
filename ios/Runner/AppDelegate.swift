import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let preferenceChannel = FlutterMethodChannel(name: "jp.gr.java_conf.foobar.testmaker.service/preferences",
                                              binaryMessenger: controller.binaryMessenger)
    preferenceChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
      // Handle battery messages.
      guard call.method == "getAllPreferences" else {
        result(FlutterMethodNotImplemented)
        return
      }

      let userDefaults = UserDefaults.standard
      let isRandom = userDefaults.bool(forKey: "isRandomOrder")
      let isSwapProblemAndAnswer = userDefaults.bool(forKey: "Reverse")
      let isSelfScoring = userDefaults.bool(forKey: "Self")
      let isAlwaysShowExplanation = userDefaults.bool(forKey: "Explanation")
      let isShowAnswerSettingDialog = userDefaults.bool(forKey: "isShowAnswerSettingListAlert")
      let playCount = userDefaults.integer(forKey: "playCount")
      let themeColor = userDefaults.integer(forKey: "colorThemeId")
      let isRemoveAds = userDefaults.bool(forKey: "RemoveAd")
      let questionCount = userDefaults.integer(forKey: "limitQuestions")
      let questionCondition = userDefaults.integer(forKey: "questionCondition")

      result([
        "isRandom" : isRandom,
        "isSwapProblemAndAnswer" : isSwapProblemAndAnswer,
        "isSelfScoring" : isSelfScoring,
        "isAlwaysShowExplanation" : isAlwaysShowExplanation,
        "questionCount" : questionCount,
        "isShowAnswerSettingDialog" : isShowAnswerSettingDialog,
        "playCount" : playCount,
        "themeColor" : themeColor,
        "isRemoveAds" : isRemoveAds,
        "questionCondition" : questionCondition
      ])
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
