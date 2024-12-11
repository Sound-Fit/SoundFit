import 'package:flutter/material.dart';

void Notification(BuildContext context, String title, String message,
    VoidCallback onPressed, VoidCallback onCancel, bool action) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (action)
          TextButton(
            onPressed: onCancel,
            child: Text('Cancel'),
          ),
        TextButton(
          onPressed: () => onPressed(),
          child: Text('OK'),
        )
      ],
    ),
  );
}
