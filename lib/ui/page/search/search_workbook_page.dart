import 'package:flutter/material.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_wrapper.dart';

class SearchWorkbookPage extends StatelessWidget {
  const SearchWorkbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppAdWrapper(
      adUnitId: AppAdUnitId.searchBanner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('さがす'),
        ),
        body: const Center(
          child: Text('SearchWorkbookPage'),
        ),
      ),
    );
  }
}
