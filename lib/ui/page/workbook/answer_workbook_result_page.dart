import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/workbook.dart';
import 'package:test_maker_native_app/router/app_router.dart';

class AnswerWorkbookResultPage extends StatelessWidget {
  const AnswerWorkbookResultPage({
    super.key,
    required this.workbook,
  });

  final Workbook workbook;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(workbook.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {
              context.router.replaceAll(
                [const RootRoute()],
              );
            },
            child: const Text('ホームに戻る'),
          ),
        ),
      ),
    );
  }
}
