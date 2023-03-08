import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/feature/setting/state/preferences_state.dart';
import 'package:test_maker_native_app/widget/app_ad_widget.dart';

class AppAdWrapper extends HookConsumerWidget {
  const AppAdWrapper({super.key, required this.adUnitId, required this.child});

  final String adUnitId;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRemovedAds = ref.watch(
      preferencesStateProvider.select((value) => value.isRemovedAds),
    );

    return Column(
      children: [
        Expanded(
          child: child,
        ),
        Visibility(
          visible: !isRemovedAds,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: AppAdWidget(
              adUnitId: adUnitId,
            ),
          ),
        ),
      ],
    );
  }
}
