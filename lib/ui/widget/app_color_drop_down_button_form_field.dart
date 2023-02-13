import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/enum/color_theme.dart';
import 'package:test_maker_native_app/ui/widget/app_dropdown_button_form_field.dart';

class AppColorDropdownButtonFormField extends StatelessWidget {
  const AppColorDropdownButtonFormField({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  final ColorTheme selectedColor;
  final void Function(ColorTheme) onChanged;

  @override
  Widget build(BuildContext context) {
    return AppDropdownButtonFormField(
      value: selectedColor,
      items: ColorTheme.values
          .map(
            (colorTheme) => DropdownMenuItem<ColorTheme?>(
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
      onChanged: (colorTheme) => onChanged(colorTheme ?? ColorTheme.blue),
      labelText: 'カラー',
      hintText: 'カラーを選択してください',
    );
  }
}
