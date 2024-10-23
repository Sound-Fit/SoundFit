import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                shadowColor: Colors.black,
                color: Colors.grey.shade200,
                child: SizedBox(
                  height: screenHeight * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'SoundFit',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: GoogleFonts.lexendGiga().fontFamily,
                              fontWeight: FontWeight.bold),
                          // textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                )),
            Card(
                color: Color(0xFFC3E6D0),
                child: SizedBox(
                  height: screenHeight * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('images/first-page.jpg'),
                          Gap(20.0),
                          SizedBox(
                            height: 50.0,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/login'),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: GoogleFonts.lexendGiga()
                                            .fontFamily),
                                  ),
                                )),
                          ),
                          Gap(20.0),
                          SizedBox(
                            height: 50.0,
                            child: OutlinedButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/register'),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: GoogleFonts.lexendGiga()
                                            .fontFamily),
                                  ),
                                )),
                          )
                        ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
