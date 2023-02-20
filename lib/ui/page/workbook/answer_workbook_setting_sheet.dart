import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/preferences_state.dart';
import 'package:test_maker_native_app/ui/page/setting/setting_page.dart';
import 'package:test_maker_native_app/ui/widget/app_modal_bottom_sheet.dart';

Future<T?> showAnswerWorkbookSettingSheet<T>({
  required BuildContext context,
  required VoidCallback onStart,
}) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) => _AnswerWorkbookSettingSheet(
        onStart: onStart,
      ),
    );

class _AnswerWorkbookSettingSheet extends HookConsumerWidget {
  const _AnswerWorkbookSettingSheet({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(preferencesStateProvider);
    final preferencesNotifier = ref.watch(preferencesStateProvider.notifier);

    return AppDraggableScrollableSheet(
      initialChildSize: 0.8,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnswerWorkbookSettings(
              preferences: preferences,
              preferencesNotifier: preferencesNotifier,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  context.router.pop();
                  onStart();
                },
                child: const Text('解答を開始する'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
