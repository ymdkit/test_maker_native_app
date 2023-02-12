import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_maker_native_app/state/folders_state.dart';
import 'package:test_maker_native_app/state/workbooks_state.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider);
    final workbooks = ref.watch(workbooksProvider(null));

    return Scaffold(
      appBar: AppBar(
        title: const Text('暗記メーカー'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: folders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final folder = folders[index];
                return ListTile(
                  title: Text(folder.title),
                  subtitle: Text(folder.folderId),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text(folder.title),
                          ),
                          body: ListView.builder(
                            itemCount: folder.workbooks.length,
                            itemBuilder: (context, index) {
                              final workbook = folder.workbooks[index];
                              return ListTile(
                                title: Text(workbook.title),
                                subtitle: Text(workbook.folderId ?? ''),
                                onTap: () {
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
                                            final question =
                                                workbook.questions[index];
                                            return ListTile(
                                              title: Text(question.problem,
                                                  maxLines: 2),
                                              subtitle: Text(
                                                question.answers.join(' '),
                                              ),
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
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListView.builder(
              itemCount: workbooks.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final workbook = workbooks[index];
                return ListTile(
                  title: Text(workbook.title),
                  subtitle: Text(workbook.folderId ?? ''),
                  onTap: () {
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
                                subtitle: Text(question.answers.join(' ')),
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
          ],
        ),
      ),
    );
  }
}