import 'package:flutter/material.dart';

void Notification(BuildContext context, String title, String message, VoidCallback onPressed, VoidCallback onCancel) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => onPressed(),
          child: Text('OK'),
        ),
      ],
    ),
  );
}


