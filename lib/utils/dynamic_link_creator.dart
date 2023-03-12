import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_maker_native_app/utils/app_exception.dart';

class DynamicLinkCreator {
  static TaskEither<AppException, String> create(
    BuildContext context,
    String path,
  ) {
    return TaskEither.tryCatch(
      () async {
        final dynamicLinkParams = DynamicLinkParameters(
          uriPrefix: 'https://testmaker.page.link',
          link: Uri.parse('https://ankimaker.com/$path'),
          androidParameters: const AndroidParameters(
            packageName: 'jp.gr.java_conf.foobar.testmaker.service',
            minimumVersion: 87,
          ),
          iosParameters: const IOSParameters(
            bundleId: 'jp.gr.java-conf.foobar.testmaker.service',
            minimumVersion: '2.1.5',
            appStoreId: '1201200202',
          ),
          socialMetaTagParameters: SocialMetaTagParameters(
            title: AppLocalizations.of(context)!.appName,
            description:
                '''「暗記メーカー」は、自学自習の効率化を目的とした問題集作成用のアプリです。資格習得のための勉強や、複数人への問題集の配布のために利用できます。''',
          ),
        );
        final link = await FirebaseDynamicLinks.instance
            .buildShortLink(dynamicLinkParams);
        return link.shortUrl.toString();
      },
      (e, _) => AppException.fromRawException(e: e),
    );
  }
}
