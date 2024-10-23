import 'package:flutter/material.dart';
import 'package:soundfit/widgets/navBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Home',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomNavBar(),
    );
  }
}
