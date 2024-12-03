import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, String?>> _getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Ambil data pengguna dari Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Ambil recognition_path dan age
        final recognitionPath = userDoc.data()?['recognition_path'];
        final age = userDoc.data()?['age'];
        final username = userDoc.data()?['username'];

        return {
          'recognitionPath': recognitionPath,
          'age': age?.toString(),
          'username': username?.toString()
        };
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return {
      'recognitionPath': null,
      'age': null,
      'username': null
    }; // Fallback jika data tidak ditemukan
  }

  String getAgeRange(String? ageStr) {
    if (ageStr == null) return '[Unknown Age]';

    final age = int.tryParse(ageStr);
    if (age == null) return '[Invalid Age]';

    switch (age) {
      case 0:
        return 'Children';
      case 1:
        return 'Teenagers';
      case 2:
        return 'Young Adults';
      case 3:
        return 'Adults';
      case 4:
        return 'Middle-Aged Adults';
      case 5:
        return 'Elderly Adults';
      default:
        return 'Can\'t determine age range';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Map<String, String?>>(
            future: _getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Hi...',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Text(
                  'Hi, User',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                );
              }

              // Safely get the username
              final username = snapshot.data?['username'] ?? 'User';
              return Text(
                'Hi, $username 👋',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              );
            },
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<Map<String, String?>>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to load data: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData ||
                snapshot.data?['recognitionPath'] == null) {
              return const Center(
                child: Text('No recognition path found.'),
              );
            } else {
              final recognitionPath = snapshot.data?['recognitionPath'];
              final age = snapshot.data?['age'];
              final ageRange = getAgeRange(age);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/Artist.jpg")),
                                  Gap(5),
                                  _buildArtistCard(
                                      image:
                                          Image.asset("assets/images/YnB.jpg")),
                                  Gap(5),
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/SongCover.jpg")),
                                  Gap(5),
                                  _buildArtistCard(
                                      image: Image.asset(
                                          "assets/images/Artist.jpg")),
                                  Gap(5),
                                  _buildArtistCard(
                                      image:
                                          Image.asset("assets/images/YnB.jpg")),
                                  Gap(5),
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
                              text: 'Recent Recognition',
                              fontWeight: FontWeight.bold,
                            ),
                            Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Display the image from recognitionPath
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset:
                                            Offset(0, 5), // Position of shadow
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(recognitionPath!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                BasedText(
                                    text: "$ageRange") // Show the age range
                              ],
                            ),
                          ],
                        ),
                        Gap(20),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     BasedText(
                        //       text: 'Artist Album',
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     Gap(20),
                        //     SizedBox(
                        //       height: 190,
                        //       child: ListView(
                        //         scrollDirection: Axis.horizontal,
                        //         children: <Widget>[
                        //           _buildAlbumCard(),
                        //           _buildAlbumCard(),
                        //           _buildAlbumCard(),
                        //           _buildAlbumCard(),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Gap(20),
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
              );
            }
          },
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
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: image.image,
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumCard() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 5),
      ),
      onPressed: () {},
      child: Column(
        children: [
          SizedBox(
            width: 250,
            height: 140,
            child: Image.asset('assets/images/Artist.jpg'),
          ),
          BasedText(
            text: '[Album Name]',
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          BasedText(
            text: '[Artist Name]',
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
