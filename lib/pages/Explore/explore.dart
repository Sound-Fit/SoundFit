import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            TextButton(
                onPressed: () => Navigator.pushNamed(context, '/explore/genre'),
                child: Text('Genre')),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/explore/search'),
                child: Text('Search')),
          ],
        ),
      ),
    );
  }
}
