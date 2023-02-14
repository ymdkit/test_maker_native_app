import 'package:flutter/material.dart';
import 'package:test_maker_native_app/model/question.dart';

class EditQuestionPage extends StatelessWidget {
  const EditQuestionPage({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('問題の編集'),
      ),
      body: Column(),
    );
  }
}
