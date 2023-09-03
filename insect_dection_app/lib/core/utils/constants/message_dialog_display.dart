import 'package:flutter/material.dart';

Future<void> displayMessageDialog(
    {required BuildContext context, String? message}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message!),
      actions: [
        // cancel button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Ok',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
