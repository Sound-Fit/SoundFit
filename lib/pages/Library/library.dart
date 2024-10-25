import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(31),
          AppBar(
            title: Center(
                child: TitleText(text: 'Library', textAlign: TextAlign.center)),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          Gap(20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/library/playlist'),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.playlist_play,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      SizedBox(width: 8.0),
                                      TextStyled(text: 'Playlist'),
                                    ],
                                  ),
                                  TextStyled(text: '>'),
                                ])),
                        Gap(20.0),
                        TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/library/artist'),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.mic,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      SizedBox(width: 8.0),
                                      TextStyled(text: 'Artist'),
                                    ],
                                  ),
                                  TextStyled(text: '>'),
                                ])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                            text: 'Liked Song', textAlign: TextAlign.left),
                        Gap(10.0),
                        Container(
                          height: 220,
                          child: ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0; i < 5; i++) SongCard(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                            text: 'Recently Added Song',
                            textAlign: TextAlign.left),
                        Gap(10.0),
                        Container(
                          height: 220,
                          child: ListView(
                            // This next line does the trick.
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              for (int i = 0; i < 5; i++) SongCard(context),
                            ],
                          ),
                        ),
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

  Widget SongCard(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(8),
      ),
      onPressed: () => Navigator.pushNamed(context, '/playMusic'),
      child: Column(
        children: [
          Container(
            color: Colors.grey,
            width: 140,
            height: 160,
          ),
          Text(
            'Title Song',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Artist',
            style: TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget TextStyled({required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.black,
      ),
    );
  }

  Widget TitleText({required String text, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.lexendDeca(fontSize: 24, fontWeight: FontWeight.w900),
    );
  }
}
