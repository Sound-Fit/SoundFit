import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class Album extends StatelessWidget {
  Album({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                TitleText(text: '[Album Name]', textAlign: TextAlign.center)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Album Cover
            Container(
              width: screenWidth,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/AlbumCover.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(20),
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
