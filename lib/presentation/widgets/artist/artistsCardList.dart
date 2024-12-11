import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/artist_list.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/models/songs.dart';
import 'package:soundfit/presentation/pages/playMusic.dart';

class ArtistsCardList extends StatefulWidget {
  const ArtistsCardList({super.key});

  @override
  State<ArtistsCardList> createState() => _ArtistsCardListState();
}

class _ArtistsCardListState extends State<ArtistsCardList> {
  final SongService _songService = SongService();
  late Future<List<Songs>> _artistsFuture;

  @override
  void initState() {
    super.initState();
    _artistsFuture = _songService.fetchArtistInformation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Songs>>(
      future: _artistsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Failed to load artist: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No artist found."));
        }

        final artists = snapshot.data!;
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return ArtistList(
                artistName: artist.artistName ?? 'Unknown Artist',
                artistImage: artist.artistImage ?? '',
              );
            },
          ),
        );
      },
    );
  }
}
