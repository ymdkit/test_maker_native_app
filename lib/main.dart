import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workbooks = ref.watch(workbooksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('暗記メーカー'),
      ),
      body: ListView.builder(
        itemCount: workbooks.length,
        itemBuilder: (context, index) {
          final workbook = workbooks[index];
          return ListTile(
            title: Text(workbook.title),
            subtitle: Text(workbook.workbookId),
            onTap: () {
              inspect(workbook);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text(workbook.title),
                    ),
                    body: ListView.builder(
                      itemCount: workbook.questions.length,
                      itemBuilder: (context, index) {
                        final question = workbook.questions[index];
                        return ListTile(
                          title: Text(question.problem, maxLines: 2),
                          subtitle: Text(question.answer.isNotEmpty
                              ? question.answer
                              : question.answers.join(' ')),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
