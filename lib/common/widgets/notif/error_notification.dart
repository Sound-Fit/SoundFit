import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text('Failed Age Prediction'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/camera'),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
