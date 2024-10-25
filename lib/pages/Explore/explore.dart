import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(31),
            AppBar(
              title: TitleText(text: 'Explore', textAlign: TextAlign.center),
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [],
            ),
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
                  Container(
                    height: 220,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (int i = 0; i < 5; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  width: 140,
                                  height: 160,
                                ),
                                Text('Title Song'),
                                Text('Artist')
                              ],
                            ),
                          )
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
                  Gap(10.0),
                  // Explore by Genre Grid
                  Container(
                    height: 300, // Adjust this height based on the grid
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 genres per row
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
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
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey[300], // Placeholder color
                                  ),
                                ),
                              ),
                              Gap(5),
                              Text('Genre ${index + 1}', // Placeholder text
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
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
