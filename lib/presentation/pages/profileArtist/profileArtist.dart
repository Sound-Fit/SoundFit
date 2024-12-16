import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class ProfileArtist extends StatelessWidget {
  ProfileArtist({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child:
                TitleText(text: '[Artist Name]', textAlign: TextAlign.center)),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    // Top Song
                    BasedText(
                      text: "Top Songs",
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(10),
                    // SongLists(),
                    Gap(20),

                    // Album
                    BasedText(
                      text: "Albums",
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(10),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
