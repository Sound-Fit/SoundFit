import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(31),
          AppBar(
            title: Center(
              child: TitleText(text: 'Profile', textAlign: TextAlign.center),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          Gap(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Bagian profil dengan gambar dan username
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  TextStyled(text: 'Username'),
                  Gap(5),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/profile/edit'),
                    child: Text('Edit',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Daftar playlist
                  Align(
                    alignment: Alignment.centerLeft,
                    child:
                        TitleText(text: 'Playlist', textAlign: TextAlign.left),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                                'images/SongCover.jpg'),
                                          ),
                                        ),
                                        Gap(15),
                                        TextStyled(text: 'Playlist Title'),
                                      ],
                                    ),
                                    TextStyled(
                                      text: '>',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
