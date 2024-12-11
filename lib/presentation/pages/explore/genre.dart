import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/presentation/widgets/song/songLists.dart';

class Genre extends StatelessWidget {
  const Genre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TitleText(text: 'Genre', textAlign: TextAlign.center),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: []),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Album Art Section
            Image.asset(
              'assets/images/genre.jpg',
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            Gap(20),
            // Playlist Title
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SongLists(),
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
