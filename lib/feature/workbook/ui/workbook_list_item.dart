import 'package:flutter/material.dart';
import 'package:test_maker_native_app/feature/workbook/model/workbook.dart';

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
      leading: Icon(
        Icons.edit_document,
        color: workbook.color.displayColor(),
      ),
      title: Text(
        workbook.title,
        maxLines: 2,
      ),
      subtitle: Text('問題数 ${workbook.questionCount}'),
      onTap: () => onTap(workbook),
    );
  }
}
