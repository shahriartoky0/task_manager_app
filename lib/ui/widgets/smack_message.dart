import 'package:flutter/material.dart';
import 'package:task_manager_app/Style/style.dart';

void showSnackMessage(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
      backgroundColor: isError ? colorRed : colorGreen,

    ),
  );
}
