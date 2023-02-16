import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/router/app_router.dart';
import 'package:test_maker_native_app/ui/utils/package_information.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInformationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: const Text('このアプリについて'),
            subtitle: Text('バージョン: ${packageInfo.maybeWhen(
              data: (data) => data.version,
              orElse: () => '',
            )}'),
            onLongPress: () {
              if (kDebugMode) {
                context.router.push(const DebugRoute());
              }
            },
            onTap: () => showLicensePage(
              context: context,
              applicationName: packageInfo.maybeWhen(
                data: (data) => data.appName,
                orElse: () => '',
              ),
              applicationVersion: packageInfo.maybeWhen(
                data: (data) => data.version,
                orElse: () => '',
              ),
            ),
          ),
        ],
      )),
    );
  }
}
