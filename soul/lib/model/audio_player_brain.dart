import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerBrain extends ChangeNotifier {
  final String songName, artistName, songUrl, imageUrl;

  AudioPlayerBrain(
      {this.songName, this.artistName, this.songUrl, this.imageUrl});

  audioPlayerBrain() {
    initAudio();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration;
  Duration position;
  String audioState;
  bool playing = false;
  IconData icon = Icons.play_arrow;

  initAudio() async {
    audioPlayer.setLoopMode(LoopMode.off);

    await audioPlayer.setUrl(songUrl);
    audioPlayer.durationStream.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.positionStream.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing == true) {
        audioState = "Playing";
      }

      if (playerState.playing == false) {
        audioState = "Pause";
      }

      if (playerState.processingState == ProcessingState.loading) {
        audioState = "Loading";
      }

      if (playerState.processingState == ProcessingState.completed) {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return QuoteScreen();
        // }));

        audioState = "Stopped";
        audioPlayer.seek(Duration.zero);
        icon = Icons.play_arrow;
        playing = false;
        stopAudio();
      }
      notifyListeners();
    });
  }

  void playAudio() async {
    await audioPlayer.play();
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  void seeking(Duration position) {
    audioPlayer.seek(position);
  }

  void shuffle() async {
    await audioPlayer.setShuffleModeEnabled(true);
  }

  void stopAudio() async {
    await audioPlayer.stop();
  }

  void skipToNext() async {
    await audioPlayer.seekToNext();
  }

  void disposeAudioPlayer() async {
    await audioPlayer.dispose();
  }
}
