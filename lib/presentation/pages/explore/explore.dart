import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/presentation/pages/explore/genre.dart';
import 'package:soundfit/presentation/widgets/song/songCardTemplate.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final user = FirebaseAuth.instance.currentUser;
  final PlaylistService _playlistService = PlaylistService();
  Future<List<String>> _songRecommendationIds = Future.value([]);

  @override
  void initState() {
    super.initState();
    _songRecommendationIds =
        _playlistService.getSongIdsForPlaylist(user!.uid, 'Recommendations');
  }

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
              SongCardTemplate(playlistName: 'Recommendations'),

              // Explore by Genre
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasedText(
                    text: 'Popular Genres',
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(10.0),
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
                      itemCount: genres.length,
                      itemBuilder: (context, index) {
                        return GenreCard(
                          imagePath: genres[index].imagePath,
                          genreName: genres[index].genreName,
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

class Genre {
  final String imagePath;
  final String genreName;

  Genre({required this.imagePath, required this.genreName});
}

final List<Genre> genres = [
  Genre(imagePath: 'assets/genre/pop.png', genreName: 'Pop'),
  Genre(imagePath: 'assets/genre/rock.png', genreName: 'Rock'),
  Genre(imagePath: 'assets/genre/jazz.png', genreName: 'Jazz'),
  Genre(imagePath: 'assets/genre/classical.png', genreName: 'Classical'),
  Genre(imagePath: 'assets/genre/rap.png', genreName: 'HipHop'),
  Genre(imagePath: 'assets/genre/country.png', genreName: 'Country'),
  Genre(imagePath: 'assets/genre/indie.png', genreName: 'Indie'),
  Genre(imagePath: 'assets/genre/acoustic.png', genreName: 'Acoustic'),
];

class GenreCard extends StatelessWidget {
  final String imagePath;
  final String genreName;

  const GenreCard(
      {super.key, required this.imagePath, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  GenrePage(imagePath: imagePath, genreName: genreName)),
        );
      },
      child: Image.asset(imagePath),
    );
  }
}
