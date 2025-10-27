import 'package:flutter/material.dart';

showMySnackBar({
  required String message,
  required BuildContext context,
  required bool success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    duration: const Duration(seconds: 5),
    backgroundColor: success ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
  ));
}
