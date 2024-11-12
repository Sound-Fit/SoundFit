import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class Genre extends StatelessWidget {
  const Genre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TitleText(text: 'Genre', textAlign: TextAlign.center),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: []),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Album Art Section
            Image.asset(
              'assets/images/genre.jpg',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            Gap(20),
            // Playlist Title
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Wrap Row inside Expanded to take full available width
                        Expanded(
                            child: Column(
                          children: [
                            SongButton(
                                songTitle: "Young and Beautiful",
                                artistName: "Lana Del Rey",
                                image: Image.asset("assets/images/YnB.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Paradise",
                                artistName: "Young Man",
                                image:
                                    Image.asset("assets/images/SongCover.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Born To Die",
                                artistName: "Lana Del Ray",
                                image: Image.asset("assets/images/Artist.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Young and Beautiful",
                                artistName: "Lana Del Rey",
                                image: Image.asset("assets/images/YnB.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Paradise",
                                artistName: "Young Man",
                                image:
                                    Image.asset("assets/images/SongCover.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Born To Die",
                                artistName: "Lana Del Ray",
                                image: Image.asset("assets/images/Artist.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Young and Beautiful",
                                artistName: "Lana Del Rey",
                                image: Image.asset("assets/images/YnB.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Paradise",
                                artistName: "Young Man",
                                image:
                                    Image.asset("assets/images/SongCover.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Born To Die",
                                artistName: "Lana Del Ray",
                                image: Image.asset("assets/images/Artist.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Young and Beautiful",
                                artistName: "Lana Del Rey",
                                image: Image.asset("assets/images/YnB.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Paradise",
                                artistName: "Young Man",
                                image:
                                    Image.asset("assets/images/SongCover.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Born To Die",
                                artistName: "Lana Del Ray",
                                image: Image.asset("assets/images/Artist.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Young and Beautiful",
                                artistName: "Lana Del Rey",
                                image: Image.asset("assets/images/YnB.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Paradise",
                                artistName: "Young Man",
                                image:
                                    Image.asset("assets/images/SongCover.jpg"),
                                year: 2019,
                                onPressed: () {}),
                            SongButton(
                                songTitle: "Born To Die",
                                artistName: "Lana Del Ray",
                                image: Image.asset("assets/images/Artist.jpg"),
                                year: 2019,
                                onPressed: () {}),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
