import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';

Future<T?> showAppPickerSheet<T>({
  required BuildContext context,
  required String title,
  required List<PickerItem<T>> items,
  required ValueChanged<T> onChanged,
}) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _AppPickerSheet(
        title: title,
        items: items,
        onChanged: onChanged,
      ),
    );

class _AppPickerSheet<T> extends StatelessWidget {
  const _AppPickerSheet({
    required this.title,
    required this.items,
    required this.onChanged,
  });

  final String title;
  final List<PickerItem<T>> items;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppDraggableScrollableSheet(
      builder: (sheetContext, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(title),
            ),
            ...items.map(
              (item) => InkWell(
                onTap: () {
                  sheetContext.router.pop();
                  onChanged(item.value);
                },
                child: ListTile(
                  title: Text(item.label),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class PickerItem<T> {
  const PickerItem({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;
}
