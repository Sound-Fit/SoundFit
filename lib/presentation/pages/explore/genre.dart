import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/presentation/widgets/song/songLists.dart';

class GenrePage extends StatelessWidget {
  final String genreName;
  final String imagePath;

  const GenrePage({
    super.key,
    required this.genreName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final SongService songService = SongService();

    return Scaffold(
      appBar: AppBar(
        title: TitleText(
          text: genreName,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Genre Image Section
              Center(
                child: Image.asset(
                  imagePath,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(20),

              // Songs List Section
              FutureBuilder<List<String>>(
                future: songService.getSongIdsByGenre(genreName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error loading songs: ${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  final songIds = snapshot.data ?? [];
                  if (songIds.isEmpty) {
                    return const Center(
                      child: Text("No songs found for this genre."),
                    );
                  }

                  // Pass songIds to SongLists widget
                  return SongLists(songIds: songIds);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
