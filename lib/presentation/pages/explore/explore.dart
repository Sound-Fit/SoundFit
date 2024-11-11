import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Explore', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(20),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onTap: () {
                  // Navigate to search page when tapped
                  Navigator.pushNamed(context, '/explore/search');
                },
                readOnly: true, // Prevent manual text input
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Tap to Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                      text: 'Recommend For You', textAlign: TextAlign.left),
                  Gap(10.0),
                  SizedBox(
                    height: 220,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (int i = 0; i < 5; i++) SongCard(context)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Reduced space between Recommend For You and Explore by Genre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(5.0), // Reduced gap
                  TitleText(
                      text: 'Explore by Genre', textAlign: TextAlign.left),
                  Gap(20.0),
                  // Explore by Genre Grid
                  SizedBox(
                    height: 300, // Adjust this height based on the grid
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 genres per row
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 3.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: 8, // Number of genres
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/explore/genre');
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey[300], // Placeholder color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
