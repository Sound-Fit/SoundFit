import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/pages/Library/playlist.dart'; // Import the Playlist page
import 'package:soundfit/pages/Library/artist.dart'; // Import the Artist page

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add a gap before the AppBar
      body: Column(
        children: [
          Gap(31), // Add gap before the AppBar
          AppBar(
            title: Center(
              child: Text(
                'Library',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexendDeca(
                    fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          // Submenu buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Playlist Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.playlist_play),
                          SizedBox(width: 8.0),
                          Text('Playlist'),
                        ],
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/library/playlist'),
                          child: Text('>'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Artist Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.mic),
                          SizedBox(width: 8.0),
                          Text('Artist'),
                        ],
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/library/artist'),
                          child: Text('>'),
                          style: TextButton.styleFrom(
                            alignment: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
