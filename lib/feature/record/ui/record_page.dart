import 'package:flutter/material.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/widget/app_ad_wrapper.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAdWrapper(
      adUnitId: AppAdUnitId.recordBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('学習記録'),
        ),
        body: const Center(
          child: Text('RecordPage'),
        ),
      ),
    );
  }
}
