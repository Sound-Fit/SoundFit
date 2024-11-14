import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Recommendation', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Result Classification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: AssetImage("assets/images/Artist.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      BasedText(text: "[50-60] Years")
                    ],
                  ),
                  Gap(30),

                  // Recommended Playlist
                  BasedText(
                    text: "Recommended Songs",
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(30),

                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          SongButton(
                              songTitle: "Young and Beautiful",
                              artistName: "Lana Del Rey",
                              image: Image.asset("assets/images/YnB.jpg"),
                              year: 2019,
                              onPressed: () {}),
                          SongButton(
                              songTitle: "Paradise",
                              artistName: "Young Man",
                              image: Image.asset("assets/images/SongCover.jpg"),
                              year: 2019,
                              onPressed: () {}),
                          SongButton(
                              songTitle: "Born To Die",
                              artistName: "Lana Del Ray",
                              image: Image.asset("assets/images/Artist.jpg"),
                              year: 2019,
                              onPressed: () {}),
                        ],
                      ))
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
