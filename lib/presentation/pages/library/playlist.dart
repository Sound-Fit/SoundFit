import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/playlist_card.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: TitleText(text: "Playlist", textAlign: TextAlign.center)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              // Add the functionality for the + button here
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            PlaylistCard(
                                title: "Favorite",
                                image:
                                    Image.asset('assets/images/SongCover.jpg'),
                                onPressed: () {}),
                            PlaylistCard(
                                title: "[Custom Playlist]",
                                image:
                                    Image.asset('assets/images/SongCover.jpg'),
                                onPressed: () {}),
                            PlaylistCard(
                                title: "Reccomendations",
                                image:
                                    Image.asset('assets/images/SongCover.jpg'),
                                onPressed: () {}),
                          ],
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
