import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/workbook.dart';

class EditWorkbookPage extends StatelessWidget {
  const EditWorkbookPage({
    super.key,
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('問題集の編集'),
      ),
      body: Column(),
    );
  }
}
