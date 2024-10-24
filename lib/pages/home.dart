import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gap(31),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AppBar(
              title: Text(
                'Hi, User',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
            ),
          ),
          Gap(25),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      
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
