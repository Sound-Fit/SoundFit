import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/presentation/widgets/song/songLists.dart';

class Album extends StatelessWidget {
  Album({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                TitleText(text: '[Album Name]', textAlign: TextAlign.center)),
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Album Cover
            Container(
              width: screenWidth,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/AlbumCover.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SongLists(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
