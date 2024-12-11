import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/card/genre_card.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/explore/genre.dart';
import 'package:soundfit/presentation/pages/explore/search.dart';
import 'package:soundfit/presentation/widgets/song/songCardList.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Recommend For You
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BasedText(
                          text: 'Recommend For You',
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(10.0),
                        SongCardlist(),
                      ]),
                ],
              ),
              Gap(20),

              // Explore by Genre
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasedText(
                    text: 'Explore by Genre',
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(20.0),
                  SizedBox(
                    height: 300,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 3.0,
                        childAspectRatio: 1,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return GenreCard(
                          image: Image.asset('assets/images/genre.jpg'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Genre()),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
