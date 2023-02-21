import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';

class AppSectionTitle extends HookConsumerWidget {
  const AppSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor =
        ref.watch(preferencesStateProvider.select((value) => value.themeColor));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: themeColor.displayColor(),
              ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
