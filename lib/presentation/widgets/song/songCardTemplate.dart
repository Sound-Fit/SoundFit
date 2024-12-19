import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/presentation/widgets/song/songCardList.dart';

class SongCardTemplate extends StatefulWidget {
  const SongCardTemplate({
    super.key,
    required this.playlistName,
  });

  final String playlistName;

  @override
  State<SongCardTemplate> createState() => _SongCardTemplateState();
}

class _SongCardTemplateState extends State<SongCardTemplate> {
  final user = FirebaseAuth.instance.currentUser;
  final PlaylistService _playlistService = PlaylistService();
  Future<List<String>> _songIds = Future.value([]);

  @override
  void initState() {
    super.initState();
    if (widget.playlistName == 'Songs') {
      _songIds = _playlistService.getAllSongIds();
    } else {
      _songIds = _playlistService.getSongIdsForPlaylist(
          user!.uid, widget.playlistName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: _songIds,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading songs: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return SizedBox.shrink();
          } else {
            final songIds = snapshot.data!;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasedText(
                    text: widget.playlistName,
                    fontWeight: FontWeight.bold,
                  ),
                  Gap(10.0),
                  SongCardlist(
                    songIds: songIds,
                  ),
                ]);
          }
        });
  }
}
