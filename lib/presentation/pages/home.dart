import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasedText(
                              text: 'Followed Artist',
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 130,
                              child: ListView(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/Artist.jpg")),
                                  _buildArtistCard(
                                      image:
                                          Image.asset("assets/images/YnB.jpg")),
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/SongCover.jpg")),
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/Artist.jpg")),
                                  _buildArtistCard(
                                      image:
                                          Image.asset("assets/images/YnB.jpg")),
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/SongCover.jpg")),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasedText(
                              text: 'Recent',
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 170,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  _buildRecentCard(),
                                  _buildRecentCard(),
                                  _buildRecentCard(),
                                  _buildRecentCard(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasedText(
                              text: 'Recommend For You',
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 220,
                              child: ListView(
                                // This next line does the trick.
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  SongCard(
                                      songTitle: "Young and Beautiful",
                                      artistName: "Lana Del Ray",
                                      image:
                                          Image.asset("assets/images/YnB.jpg"),
                                      onPressed: () {}),
                                  SongCard(
                                      songTitle: "Paradise",
                                      artistName: "Young Man",
                                      image: Image.asset(
                                          "assets/images/SongCover.jpg"),
                                      onPressed: () {}),
                                  SongCard(
                                      songTitle: "Born To Die",
                                      artistName: "Lana Del Ray",
                                      image: Image.asset(
                                          "assets/images/Artist.jpg"),
                                      onPressed: () {}),
                                  SongCard(
                                      songTitle: "Young and Beautiful",
                                      artistName: "Lana Del Ray",
                                      image:
                                          Image.asset("assets/images/YnB.jpg"),
                                      onPressed: () {}),
                                  SongCard(
                                      songTitle: "Paradise",
                                      artistName: "Young Man",
                                      image: Image.asset(
                                          "assets/images/SongCover.jpg"),
                                      onPressed: () {}),
                                  SongCard(
                                      songTitle: "Born To Die",
                                      artistName: "Lana Del Ray",
                                      image: Image.asset(
                                          "assets/images/Artist.jpg"),
                                      onPressed: () {}),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtistCard({required Image image}) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 1),
      ),
      onPressed: () {},
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white, // Warna latar belakang untuk kontras
          image: DecorationImage(
            image: image.image,
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Warna bayangan
              spreadRadius: 2, // Seberapa jauh bayangan menyebar
              blurRadius: 3, // Ketajaman bayangan
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentCard() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
      onPressed: () {},
      child: SizedBox(
        width: 250,
        height: 140,
        // color: Colors.grey,
        child: Image.asset('assets/images/Artist.jpg'),
      ),
    );
  }
}
