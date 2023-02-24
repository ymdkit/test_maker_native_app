import 'package:flutter/material.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';

class EditGroupPage extends StatelessWidget {
  const EditGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAdWrapper(
      adUnitId: AppAdUnitId.createGroupBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('グループ編集'),
        ),
        body: const Center(
          child: Text('GroupDetailsPage'),
        ),
      ),
    );
  }
}
