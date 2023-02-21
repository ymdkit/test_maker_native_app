import 'package:flutter/material.dart';
import 'package:test_maker_native_app/ui/widget/app_ad_widget.dart';

class AppAdWrapper extends StatelessWidget {
  const AppAdWrapper({super.key, required this.adUnitId, required this.child});

  final String adUnitId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: child,
        ),
        AppAdWidget(
          adUnitId: adUnitId,
        ),
      ],
    );
  }
}
