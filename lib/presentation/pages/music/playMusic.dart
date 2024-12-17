import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/notif/add_songPlaylist.dart';
import 'package:soundfit/common/widgets/notif/loading_notification.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/constants/app_urls.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayMusic extends StatefulWidget {
  final String musicId;
  final String beforeId;
  const PlayMusic({super.key, required this.musicId, this.beforeId = ''});

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  final user = FirebaseAuth.instance.currentUser;
  final player = AudioPlayer();
  final SongService _songService = SongService();
  late Future<String> _nextId;
  late Future<String> _songId;
  late Songs songs;

  @override
  void initState() {
    super.initState();
    _nextId = _songService.getRandomMusicId().then((value) => value ?? '');
    _songId = _songService
        .getSongIdFromTrackId(widget.musicId)
        .then((value) => value ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingNotification(context);
    });

    final credentials =
        SpotifyApiCredentials(AppUrls.clientId, AppUrls.clientSecret);
    final spotify = SpotifyApi(credentials);
    songs = Songs(trackId: widget.musicId);

    spotify.tracks.get(songs.trackId).then((track) async {
      String? tempSongTitle = track.name;

      if (tempSongTitle != null) {
        songs.songTitle = tempSongTitle;
        songs.artistName = track.artists?.first.name ?? "";
        String? image = track.album?.images?.first.url;
        if (image != null) {
          songs.coverImage = image;
        }

        final yt = YoutubeExplode();
        final video =
            (await yt.search.search("$tempSongTitle ${songs.artistName ?? ""}"))
                .first;
        final videoId = video.id.value;
        songs.duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.first.url;

        await player.play(UrlSource(audioUrl.toString()));
      }
      dismissLoadingNotification(context);
    }).catchError((error) {
      dismissLoadingNotification(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load the song: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();
        Navigator.pop(context, widget.beforeId);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await player.stop();
              Navigator.pop(context, widget.beforeId);
            },
          ),
          title: TitleText(
            text: 'Play Music',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cover Image
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: songs.coverImage != null
                          ? NetworkImage(songs.coverImage!)
                          : AssetImage('assets/images/nullSongCover.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(20),

                // Title and Artist
                BasedText(
                  text: songs.songTitle ?? '-',
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  fontSize: 24,
                ),
                Gap(5),
                BasedText(
                  text: songs.artistName ?? '-',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),

                // Button Like and Add Playlist
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            // offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          final playlistService = PlaylistService();
                          final userId =
                              user?.uid; // Replace with actual user ID
                          final songId = await _songId;
                          final songTitle = songs.songTitle ?? '-';
                          await playlistService.addLikedSong(userId!, songId);
                          // Optionally, show a success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('$songTitle added to liked songs!')),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            // offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                        onPressed: () async {
                          final userId =
                              user?.uid; // Replace with actual user ID
                          final songId = await _songId;
                          final songTitle = songs.songTitle ?? '-';
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AddSongPlaylist(
                                songId: songId,
                                userId: userId!,
                              );
                            },
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('$songTitle added to playlist!')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Gap(20),

                // Track Duration
                StreamBuilder<Duration>(
                  stream: player.onPositionChanged,
                  builder: (context, snapshot) {
                    final progress = snapshot.data ?? Duration(seconds: 0);
                    final total = songs.duration ?? Duration(minutes: 4);

                    // Jika progress hampir sama dengan durasi total
                    if (progress >= total - const Duration(seconds: 1)) {
                      // Reset posisi ke awal dan pause player
                      player.pause();
                      player.seek(Duration.zero);
                    }

                    return ProgressBar(
                      progress: progress,
                      total: total,
                      baseBarColor: Colors.grey[300],
                      progressBarColor: Colors.black,
                      bufferedBarColor: Colors.grey,
                      thumbColor: Colors.black,
                      onSeek: (duration) {
                        player.seek(duration);
                      },
                    );
                  },
                ),
                Gap(20),

                // Play and Pause Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Skip to Previous Song
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 40,
                        color: widget.beforeId.isEmpty
                            ? Colors.grey
                            : Colors.black,
                      ),
                      onPressed: widget.beforeId.isEmpty
                          ? null
                          : () async {
                              await player.stop(); // Stop the current song
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayMusic(
                                    musicId: widget.beforeId,
                                  ),
                                ),
                              );
                            },
                    ),

                    // Skip Backward 10 seconds
                    IconButton(
                      icon: const Icon(
                        Icons.replay_10,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        final position = await player.getCurrentPosition();
                        final newPosition = position! - Duration(seconds: 10);
                        if (newPosition < Duration.zero) {
                          await player.seek(Duration
                              .zero); // Jangan biarkan posisi lebih kecil dari 0
                        } else {
                          await player.seek(newPosition);
                        }
                      },
                    ),

                    // Play/Pause
                    StreamBuilder<PlayerState>(
                      stream: player
                          .onPlayerStateChanged, // Menggunakan stream untuk mendengarkan perubahan state player
                      builder: (context, snapshot) {
                        // Ambil state terbaru dari snapshot
                        final playerState = snapshot.data ??
                            PlayerState.paused; // Default ke paused jika null

                        return IconButton(
                          icon: Icon(
                            playerState == PlayerState.playing
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            size: 60,
                          ),
                          onPressed: () async {
                            if (playerState == PlayerState.playing) {
                              await player.pause(); // Pause jika sedang bermain
                            } else {
                              await player
                                  .resume(); // Resume jika sedang berhenti
                            }
                            setState(
                                () {}); // Memanggil setState agar tampilan ter-update
                          },
                        );
                      },
                    ),

                    // Skip Forward 10 seconds
                    IconButton(
                      icon: const Icon(
                        Icons.forward_10,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        final position = await player.getCurrentPosition();
                        final newPosition = position! + Duration(seconds: 10);
                        final totalDuration =
                            songs.duration ?? Duration(minutes: 4);
                        if (newPosition > totalDuration) {
                          await player.seek(
                              totalDuration); // Jangan biarkan posisi lebih besar dari durasi total
                        } else {
                          await player.seek(newPosition);
                        }
                      },
                    ),

                    // Skip to Next Song
                    IconButton(
                      icon: const Icon(
                        Icons.skip_next,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        await player.stop(); // Stop the current song
                        final nextId = await _nextId;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayMusic(
                              musicId: nextId,
                              beforeId: widget.musicId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }
}
