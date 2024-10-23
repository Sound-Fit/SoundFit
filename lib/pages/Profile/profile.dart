import 'package:flutter/material.dart';
import 'package:soundfit/widgets/navBar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Text('Profile'),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/profile/edit'),
            child: Text('Ini tombol edit')),
        TextButton(
            onPressed: () => Navigator.pushNamed(context, '/library/playlist'),
            child: Text('Ini tombol playlist')),
      ],
    ));
  }
}
