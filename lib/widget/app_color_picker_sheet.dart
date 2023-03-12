import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:test_maker_native_app/constants/color_theme.dart';
import 'package:test_maker_native_app/widget/app_modal_bottom_sheet.dart';

Future<T?> showAppColorPickerSheet<T>({
  required BuildContext context,
  required ValueChanged<AppThemeColor> onChanged,
}) async =>
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => _AppPickerSheet(
        onChanged: onChanged,
      ),
    );

class _AppPickerSheet extends StatelessWidget {
  const _AppPickerSheet({
    required this.onChanged,
  });

  final ValueChanged<AppThemeColor> onChanged;

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
              child: Text(AppLocalizations.of(context)!.color),
            ),
            ...AppThemeColor.values.map(
              (item) => ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.displayColor(),
                  ),
                ),
                title: Text(item.displayString(context)),
                onTap: () {
                  sheetContext.router.pop();
                  onChanged(item);
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
