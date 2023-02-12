import 'package:flutter/material.dart';

void showAppSnackBar(
  BuildContext context,
  String content,
) {
  final snack = SnackBar(
    content: Text(content),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
