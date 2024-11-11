import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Artist extends StatelessWidget {
  const Artist({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(31),
          AppBar(
            title: Center(
                child: TitleText(text: 'Artist', textAlign: TextAlign.center)),
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
              )
            ],
          ),
          Gap(25),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
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
                                  Row(children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Warna latar belakang untuk kontras
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                  0.1), // Warna bayangan
                                              spreadRadius:
                                                  2, // Seberapa jauh bayangan menyebar
                                              blurRadius:
                                                  3, // Ketajaman bayangan
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(25.0)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        child: Image.asset('images/Artist.jpg'),
                                      ),
                                    ),
                                    Gap(15),
                                    TextStyled(text: 'Artist Name'),
                                  ]),
                                ],
                              )),
                        )
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
