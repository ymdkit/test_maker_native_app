import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/folder.dart';
import 'package:test_maker_native_app/ui/widget/app_dropdown_button_form_field.dart';

class AppFolderDropdownButtonFormField extends StatelessWidget {
  const AppFolderDropdownButtonFormField({
    super.key,
    required this.selectedFolder,
    required this.folders,
    required this.onChanged,
  });

  final Folder? selectedFolder;
  final List<Folder> folders;
  final ValueChanged<Folder?> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppDropdownButtonFormField<Folder?>(
      value: selectedFolder,
      items: folders
          .map((folder) => DropdownMenuItem<Folder?>(
                value: folder,
                child: Row(
                  children: [
                    Icon(
                      Icons.folder,
                      color: folder.color.displayColor(),
                    ),
                    const SizedBox(width: 16),
                    Text(folder.title),
                  ],
                ),
              ))
          .toList(),
      onChanged: onChanged,
      labelText: 'フォルダ',
      hintText: 'フォルダを選択してください',
    );
  }
}
