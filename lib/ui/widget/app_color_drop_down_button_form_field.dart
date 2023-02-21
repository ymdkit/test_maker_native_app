import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/ui/widget/app_dropdown_button_form_field.dart';

class AppColorDropdownButtonFormField extends StatelessWidget {
  const AppColorDropdownButtonFormField({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  final AppThemeColor selectedColor;
  final void Function(AppThemeColor) onChanged;

  @override
  Widget build(BuildContext context) {
    return AppDropdownButtonFormField(
      value: selectedColor,
      items: AppThemeColor.values
          .map(
            (colorTheme) => DropdownMenuItem<AppThemeColor?>(
              value: colorTheme,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorTheme.displayColor(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(colorTheme.displayString()),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (colorTheme) => onChanged(colorTheme ?? AppThemeColor.blue),
      labelText: 'カラー',
      hintText: 'カラーを選択してください',
    );
  }
}
