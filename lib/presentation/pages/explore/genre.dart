import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Genre extends StatelessWidget {
  const Genre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(31),
          AppBar(
              title: TitleText(text: 'Genre', textAlign: TextAlign.center),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              actions: []),
          // Album Art Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset(
              'assets/images/genre.jpg',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Gap(20),
          // Playlist Title
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                for (int i = 0; i < 5; i++)
                  PlaylistItem(
                    album: 'Get Weird',
                    year: '2015',
                    songTitle: 'Black Magic',
                    albumImage: 'assets/images/SongCover.jpg',
                    textStyle:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                    songTitleStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget TextStyled(
      {required String text, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: fontWeight,
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

class PlaylistItem extends StatelessWidget {
  final String album;
  final String year;
  final String songTitle;
  final String albumImage;
  final TextStyle textStyle;
  final TextStyle songTitleStyle;

  PlaylistItem({
    required this.album,
    required this.year,
    required this.songTitle,
    required this.albumImage,
    required this.textStyle,
    required this.songTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Album Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(albumImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap(15),
          // Album and Song Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$album - $year',
                  style: textStyle,
                ),
                Text(
                  songTitle,
                  style: songTitleStyle,
                ),
              ],
            ),
          ),
          // 3 dots menu icon
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Define the action for more options here
            },
          ),
        ],
      ),
    );
  }
}
