import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/menu_button.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/presentation/pages/Library/artist.dart';
import 'package:soundfit/presentation/pages/library/playlist.dart';

class Library extends StatelessWidget {
  Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: TitleText(text: 'Library', textAlign: TextAlign.center)),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        MenuButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Playlist()),
                              );
                            },
                            title: "Playlist",
                            icon: Icons.playlist_play,
                            iconSize: 20),
                        MenuButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Artist()),
                              );
                            },
                            title: "Artist",
                            icon: Icons.mic,
                            iconSize: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasedText(
                            text: 'Liked Song', fontWeight: FontWeight.bold),
                        Gap(10.0),
                        // SizedBox(
                        //   height: 220,
                        //   child: ListView(
                        //     // This next line does the trick.
                        //     scrollDirection: Axis.horizontal,
                        //     children: <Widget>[
                        //       SongCard(
                        //           songTitle: "Young and Beautiful",
                        //           artistName: "Lana Del Ray",
                        //           image: Image.asset("assets/images/YnB.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Paradise",
                        //           artistName: "Young Man",
                        //           image: Image.asset(
                        //               "assets/images/SongCover.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Born To Die",
                        //           artistName: "Lana Del Ray",
                        //           image:
                        //               Image.asset("assets/images/Artist.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Young and Beautiful",
                        //           artistName: "Lana Del Ray",
                        //           image: Image.asset("assets/images/YnB.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Paradise",
                        //           artistName: "Young Man",
                        //           image: Image.asset(
                        //               "assets/images/SongCover.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Born To Die",
                        //           artistName: "Lana Del Ray",
                        //           image:
                        //               Image.asset("assets/images/Artist.jpg"),
                        //           onPressed: () {}),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasedText(
                          text: 'Recently Added Song',
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(10.0),
                        // SizedBox(
                        //   height: 220,
                        //   child: ListView(
                        //     // This next line does the trick.
                        //     scrollDirection: Axis.horizontal,
                        //     children: <Widget>[
                        //       SongCard(
                        //           songTitle: "Paradise",
                        //           artistName: "Young Man",
                        //           image: Image.asset(
                        //               "assets/images/SongCover.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Young and Beautiful",
                        //           artistName: "Lana Del Ray",
                        //           image: Image.asset("assets/images/YnB.jpg"),
                        //           onPressed: () {}),
                        //       SongCard(
                        //           songTitle: "Born To Die",
                        //           artistName: "Lana Del Ray",
                        //           image:
                        //               Image.asset("assets/images/Artist.jpg"),
                        //           onPressed: () {}),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Submenu buttons
        ],
      ),
    );
  }
}
