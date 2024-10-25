import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayMusic extends StatefulWidget {
  @override
  _PlayMusicState createState() => _PlayMusicState();
}

class _PlayMusicState extends State<PlayMusic> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentSong =
      "https://soundcloud.com/billieeilish/birds-of-a-feather?utm_source=clipboard&utm_medium=text&utm_campaign=social_sharing";

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseAudio() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(currentSong));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playPauseAudio,
              child: Text(isPlaying ? 'Pause' : 'Play'),
            ),
          ],
        ),
      ),
    );
  }
}
