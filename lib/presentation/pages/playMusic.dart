import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/constants/app_urls.dart';
import 'package:soundfit/models/songs.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayMusic extends StatefulWidget {
  final String musicId;
  const PlayMusic({super.key, required this.musicId});

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  final player = AudioPlayer();

  late Songs songs;

  @override
  void initState() {
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
        player.play(UrlSource(audioUrl.toString()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await player.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
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
                  height: screenHeight(context) * 0.4,
                  width: screenWidth(context) * 0.8,
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
                        onPressed: () {},
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
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Gap(20),

                // Track Duration
                StreamBuilder(
                    stream: player.onPositionChanged,
                    builder: (context, snapshot) {
                      return ProgressBar(
                        progress: snapshot.data ?? Duration(seconds: 0),
                        // buffered: Duration(minutes: 1, seconds: 30),
                        total: songs.duration ?? Duration(minutes: 4),
                        baseBarColor: Colors.grey[300],
                        progressBarColor: Colors.black,
                        bufferedBarColor: Colors.grey,
                        thumbColor: Colors.black,
                        onSeek: (duration) {
                          player.seek(duration);
                        },
                      );
                    }),
                Gap(20),

                // Play and Pause Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        player.state == PlayerState.playing
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        size: 60,
                      ),
                      onPressed: () async {
                        if (player.state == PlayerState.playing) {
                          await player.pause();
                        } else {
                          await player.resume();
                        }
                        setState(() {});
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.skip_next,
                        size: 40,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
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
