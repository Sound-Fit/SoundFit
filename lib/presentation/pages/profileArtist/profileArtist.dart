import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/presentation/pages/profileArtist/album.dart';

class ProfileArtist extends StatelessWidget {
  ProfileArtist({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                TitleText(text: '[Artist Name]', textAlign: TextAlign.center)),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    // Top Song
                    BasedText(
                      text: "Top Songs",
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(10),
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
                          ],
                        )),
                      ],
                    ),
                    Gap(20),

                    // Album
                    BasedText(
                      text: "Albums",
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(10),
                    // SizedBox(
                    //   height: 220,
                    //   child: ListView(
                    //     // This next line does the trick.
                    //     scrollDirection: Axis.horizontal,
                    //     children: <Widget>[
                    //       SongCard(
                    //         songTitle: "Young and Beautiful",
                    //         artistName: "Lana Del Ray",
                    //         image: Image.asset("assets/images/YnB.jpg"),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) => Album()),
                    //           );
                    //         },
                    //       ),
                    //       SongCard(
                    //         songTitle: "Paradise",
                    //         artistName: "Young Man",
                    //         image: Image.asset("assets/images/SongCover.jpg"),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) => Album()),
                    //           );
                    //         },
                    //       ),
                    //       SongCard(
                    //         songTitle: "Born To Die",
                    //         artistName: "Lana Del Ray",
                    //         image: Image.asset("assets/images/Artist.jpg"),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) => Album()),
                    //           );
                    //         },
                    //       ),
                    //       SongCard(
                    //         songTitle: "Young and Beautiful",
                    //         artistName: "Lana Del Ray",
                    //         image: Image.asset("assets/images/YnB.jpg"),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) => Album()),
                    //           );
                    //         },
                    //       ),
                    //       SongCard(
                    //         songTitle: "Paradise",
                    //         artistName: "Young Man",
                    //         image: Image.asset("assets/images/SongCover.jpg"),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) => Album()),
                    //           );
                    //         },
                    //       ),
                    //       SongCard(
                    //         songTitle: "Born To Die",
                    //         artistName: "Lana Del Ray",
                    //         image: Image.asset("assets/images/Artist.jpg"),
                    //         onPressed: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (BuildContext context) => Album()),
                    //           );
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
