import 'package:flutter/material.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAdWrapper(
      adUnitId: AppAdUnitId.groupListBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('グループ一覧'),
        ),
        body: const Center(
          child: Text('GroupListPage'),
        ),
      ),
    );
  }
}
