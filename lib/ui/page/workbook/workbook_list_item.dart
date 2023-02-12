import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/workbook.dart';

class WorkbookListItem extends StatelessWidget {
  const WorkbookListItem({
    super.key,
    required this.workbook,
    required this.onTap,
  });

  final Workbook workbook;
  final void Function(Workbook workbook) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workbook.title),
      subtitle: Text(workbook.folderId ?? ''),
      onTap: () => onTap(workbook),
    );
  }
}
