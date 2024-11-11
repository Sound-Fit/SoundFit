import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/presentation/pages/playMusic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi, User',
          style: TextStyle(fontSize: 17, color: Colors.grey),
        ),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleText(
                                text: 'Followed Artist',
                                textAlign: TextAlign.left),
                            Gap(20.0),
                            SizedBox(
                              height: 130,
                              child: ListView(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  for (int i = 0; i < 5; i++)
                                    Column(
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1),
                                          ),
                                          onPressed: () {},
                                          child: Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .white, // Warna latar belakang untuk kontras
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(
                                                            0.1), // Warna bayangan
                                                    spreadRadius:
                                                        2, // Seberapa jauh bayangan menyebar
                                                    blurRadius:
                                                        3, // Ketajaman bayangan
                                                  ),
                                                ],
                                              ),
                                              child: Container(
                                                color: Colors.white,
                                              )
                                              // Image.asset(
                                              //     'images/Artist.jpg'),
                                              ),
                                        )
                                      ],
                                    )
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
                                text: 'Recent', textAlign: TextAlign.left),
                            Gap(20.0),
                            SizedBox(
                              height: 170,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  for (int i = 0; i < 5; i++)
                                    Column(
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                          ),
                                          onPressed: () {},
                                          child: SizedBox(
                                            width: 250,
                                            height: 140,
                                            // color: Colors.grey,
                                            child: Image.asset(
                                                'assets/images/Artist.jpg'),
                                          ),
                                        )
                                      ],
                                    )
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
                                text: 'Recommend For You',
                                textAlign: TextAlign.left),
                            Gap(20.0),
                            SizedBox(
                              height: 150,
                              child: ListView(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  for (int i = 0; i < 5; i++)
                                    Column(
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5),
                                          ),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PlayMusic()),
                                          ),
                                          child: Container(
                                            width: 140,
                                            height: 140,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    )
                                ],
                              ),
                            ),
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
