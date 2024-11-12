import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/artist_card.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class Artist extends StatelessWidget {
  const Artist({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ArtistCard(
                                title: "Lana Del Rey",
                                image: Image.asset("assets/images/Artist.jpg"),
                                onPressed: () {}),
                            ArtistCard(
                                title: "Lana Del Rey",
                                image: Image.asset("assets/images/Artist.jpg"),
                                onPressed: () {}),
                            ArtistCard(
                                title: "Lana Del Rey",
                                image: Image.asset("assets/images/Artist.jpg"),
                                onPressed: () {})
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
}
