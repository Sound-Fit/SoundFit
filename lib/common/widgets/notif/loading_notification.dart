import 'package:flutter/material.dart';

void showLoadingNotification(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside the dialog
    builder: (_) => AlertDialog(
      title: Text('Loading Song'),
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 20),
          Expanded(child: Text('Please wait while the song is loading...')),
        ],
      ),
    ),
  );
}

void dismissLoadingNotification(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
}
