import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/notif/add_songPlaylist.dart';
import 'package:soundfit/common/widgets/notif/loading_notification.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayMusic extends StatefulWidget {
  final List<Songs> songs;
  final int index;

  const PlayMusic({super.key, required this.songs, required this.index});

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  final user = FirebaseAuth.instance.currentUser;
  final player = AudioPlayer();
  final SongService _songService = SongService();
  late Songs songs;
  late Future<String> _songId;

  @override
  void initState() {
    super.initState();
    songs = widget.songs[widget.index];
    _songId = _songService
        .getSongIdFromTrackId(songs.trackId)
        .then((value) => value ?? '');

    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingNotification(context);
    });

    try {
      final String? tempSongTitle = songs.songTitle;
      if (tempSongTitle != null) {
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load the song: $e')),
      );
    } finally {
      dismissLoadingNotification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              await player.stop();
              Navigator.pop(context);
            },
          ),
          title: const TitleText(
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
                          : const AssetImage('assets/images/nullSongCover.jpg')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(20),

                // Title and Artist
                BasedText(
                  text: songs.songTitle ?? '-',
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  fontSize: 24,
                ),
                const Gap(5),
                BasedText(
                  text: songs.artistName ?? '-',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),

                // Button Like and Add Playlist
                const Gap(20),
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
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () async {
                          try {
                            final playlistService = PlaylistService();
                            final userId = user?.uid;
                            final songId = await _songId;
                            await playlistService.addLikedSong(userId!, songId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${songs.songTitle} added to liked songs!')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Failed to add song to liked songs: $e')),
                            );
                          }
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
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.grey),
                        onPressed: () async {
                          final userId = user?.uid;
                          final songId = await _songId;
                          showDialog(
                            context: context,
                            builder: (context) => AddSongPlaylist(
                              songId: songId,
                              userId: userId!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(20),

                // Track Duration
                StreamBuilder<Duration>(
                  stream: player.onPositionChanged,
                  builder: (context, snapshot) {
                    final progress = snapshot.data ?? Duration.zero;
                    final total = songs.duration ?? const Duration(minutes: 4);

                    if (progress >= total - const Duration(seconds: 1)) {
                      if (widget.index < widget.songs.length - 1) {
                        // Delay navigation to avoid calling setState during build phase
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          player.stop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayMusic(
                                songs: widget.songs,
                                index: widget.index + 1,
                              ),
                            ),
                          );
                        });
                      } else {
                        player.pause();
                        player.seek(Duration.zero);
                      }
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
                const Gap(20),

                // Play and Pause Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        size: 40,
                        color: widget.index == 0 ? Colors.grey : Colors.black,
                      ),
                      onPressed: widget.index == 0
                          ? null
                          : () async {
                              await player.stop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayMusic(
                                    songs: widget.songs,
                                    index: widget.index - 1,
                                  ),
                                ),
                              );
                            },
                    ),
                    IconButton(
                      icon: const Icon(Icons.replay_10,
                          color: Color.fromARGB(255, 120, 120, 120), size: 30),
                      onPressed: () async {
                        final position = await player.getCurrentPosition();
                        if (position != null) {
                          await player
                              .seek(position - const Duration(seconds: 10));
                        }
                      },
                    ),
                    StreamBuilder<PlayerState>(
                      stream: player.onPlayerStateChanged,
                      builder: (context, snapshot) {
                        final state = snapshot.data ?? PlayerState.paused;
                        return IconButton(
                          icon: Icon(
                            state == PlayerState.playing
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            size: 60,
                          ),
                          onPressed: () async {
                            if (state == PlayerState.playing) {
                              await player.pause();
                            } else {
                              await player.resume();
                            }
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10,
                          color: Color.fromARGB(255, 120, 120, 120), size: 30),
                      onPressed: () async {
                        final position = await player.getCurrentPosition();
                        final total = songs.duration ?? Duration.zero;
                        if (position != null &&
                            position + const Duration(seconds: 10) <= total) {
                          await player
                              .seek(position + const Duration(seconds: 10));
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        size: 40,
                        color: widget.index == widget.songs.length - 1
                            ? Colors.grey
                            : Colors.black,
                      ),
                      onPressed: widget.index == widget.songs.length - 1
                          ? null
                          : () async {
                              await player.stop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayMusic(
                                    songs: widget.songs,
                                    index: widget.index + 1,
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
