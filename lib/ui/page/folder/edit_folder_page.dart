import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/folder.dart';

class EditFolderPage extends StatelessWidget {
  const EditFolderPage({
    super.key,
    required this.folder,
  });

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('フォルダの編集'),
      ),
      body: Column(),
    );
  }
}
