import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
