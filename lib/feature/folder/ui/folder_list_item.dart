import 'package:flutter/material.dart';
import 'package:test_maker_native_app/feature/folder/model/folder.dart';

class FolderListItem extends StatelessWidget {
  const FolderListItem({
    super.key,
    required this.folder,
    required this.onTap,
  });

  final Folder folder;
  final void Function(Folder) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.folder,
        color: folder.color.displayColor(),
      ),
      title: Text(folder.title),
      subtitle: Text('問題集数 ${folder.workbookCount}'),
      onTap: () => onTap(folder),
    );
  }
}
