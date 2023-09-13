import 'package:flutter/material.dart';

void showTopSnackBar(
  context, {
  required String? message,
  bool isSuccess = false,
  Color? color,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message ?? 'Unknown'),
      behavior: SnackBarBehavior.floating,
      backgroundColor:
          color ?? (isSuccess ? Colors.greenAccent : Colors.redAccent),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 200,
        right: 25,
        left: 25,
      ),
      duration: duration ?? const Duration(seconds: 3),
    ),
  );
}
