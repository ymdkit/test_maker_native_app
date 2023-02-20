import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/ui/utils/package_information.dart';
import 'package:test_maker_native_app/ui/widget/app_section_title.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: AppSectionTitle(title: '出題設定'),
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
        ],
      )),
    );
  }
}
