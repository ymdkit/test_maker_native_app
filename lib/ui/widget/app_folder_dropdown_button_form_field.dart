import 'package:collection/collection.dart';
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
    return AppDropdownButtonFormField<String?>(
      value: selectedFolder?.folderId,
      items: folders
          .map((folder) => DropdownMenuItem<String?>(
                value: folder.folderId,
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
      onChanged: (folderId) => onChanged(
        folders.firstWhereOrNull((folder) => folder.folderId == folderId),
      ),
      labelText: 'フォルダ',
      hintText: 'フォルダを選択してください',
    );
  }
}
