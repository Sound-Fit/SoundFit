import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:soundfit/presentation/pages/home/home.dart';
import 'package:soundfit/presentation/pages/explore/explore.dart';
import 'package:soundfit/presentation/pages/camera/camera.dart';
import 'package:soundfit/presentation/pages/library/library.dart';
import 'package:soundfit/presentation/pages/playlist/recommendation.dart';
import 'package:soundfit/presentation/pages/profile/profile.dart';

class CustomNavBar extends StatefulWidget {
  final CameraDescription camera;
  final int selectedIndex;

  const CustomNavBar({Key? key, required this.camera, this.selectedIndex = 0})
      : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget
        .selectedIndex; // Gunakan `selectedIndex` dari widget sebagai nilai awal
  }

  // List of pages to navigate
  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    Library(),
    Profile(),
    RecommendationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, -3), // Change the position of the shadow
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, size: 30),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.music_note_rounded,
                    size: 30,
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                ),

                // Camera button styled to float in appearance
                Container(
                  width: 70, // Size for the camera button container
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 1, // How much the shadow spreads
                        blurRadius: 3, // Softness of the shadow
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera,
                        size: 50,
                        color: Colors.black), // Bigger size for the camera icon
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CameraScreen(camera: widget.camera)),
                    ),
                    padding: EdgeInsets.zero, // Remove default padding
                    constraints:
                        BoxConstraints(), // Remove constraints for better centering
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.queue_music, size: 30),
                  onPressed: () {
                    _onItemTapped(2);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_circle, size: 30),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
