import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/artist_card.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';

class ArtistsLists extends StatefulWidget {
  const ArtistsLists({super.key});

  @override
  State<ArtistsLists> createState() => _ArtistsListsState();
}

class _ArtistsListsState extends State<ArtistsLists> {
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

        // Ambil data artis dan urutkan berdasarkan `artistName`
        final artists = snapshot.data!;
        artists.sort((a, b) {
          final nameA = a.artistName?.toLowerCase() ?? '';
          final nameB = b.artistName?.toLowerCase() ?? '';
          return nameA.compareTo(nameB);
        });

        return Container(
          height: MediaQuery.of(context).size.height * 0.85, // Adjust height
          child: ListView.builder(
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return ArtistCard(
                title: artist.artistName ?? 'Unknown Artist',
                image: artist.artistImage ?? '',
                onPressed: () {},
              );
            },
          ),
        );
      },
    );
  }
}
