import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/menu_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/presentation/pages/Library/artist.dart';
import 'package:soundfit/presentation/pages/library/playlist.dart';
import 'package:soundfit/presentation/widgets/song/songCardList.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
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
                    Gap(20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasedText(
                            text: 'Liked Song',
                            fontWeight: FontWeight.bold,
                          ),
                          Gap(10.0),
                          SongCardlist(),
                        ]),
                    Gap(20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasedText(
                            text: 'Songs',
                            fontWeight: FontWeight.bold,
                          ),
                          Gap(10.0),
                          SongCardlist(),
                        ]),
                  ],
                ),
              ),
            ),
            // Submenu buttons
          ],
        ),
      ),
    );
  }
}
