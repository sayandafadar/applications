import 'package:after_layout/after_layout.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:soul/utils/alert_dialog.dart';

class PlayerScreen extends StatefulWidget {
  final String songName, artistName, songUrl, imageUrl;

  PlayerScreen({this.songName, this.artistName, this.songUrl, this.imageUrl});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with AfterLayoutMixin<PlayerScreen> {
  IconData icon = Icons.play_arrow;
  bool playing = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration;
  Duration position;
  String audioState;

  checkConnectivity() async {
    if (await DataConnectionChecker().hasConnection == true) {
      print('YAY! Free cute dog pics!');
    } else {
      print('No internet :( Reason:');
      print(DataConnectionChecker().lastTryResults);

      return showNoInternetConnectionDialog();
    }
  }

  Future<void> initAudio() async {
    audioPlayer.setLoopMode(LoopMode.off);

    await audioPlayer.setUrl(widget.songUrl);
    audioPlayer.durationStream.listen((updatedDuration) {
      totalDuration = updatedDuration;
    });

    audioPlayer.positionStream.listen((updatedPosition) {
      setState(() {
        position = updatedPosition;
      });
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

  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    checkConnectivity();
  }

  void showNoInternetConnectionDialog() {
    showDialog(
      context: context,
      builder: (context) => new ShowAlertDialog(
        text: "Please connect to the internet",
        icon: Icons.warning,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: totalDuration == null ? true : false,
      opacity: 0.2,
      color: Colors.white10,
      progressIndicator: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 70.0,
        ),
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black38,
            image: DecorationImage(
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SizedBox(
                    height: 27.5.h,
                  ),
                ),
                Center(
                  child: CircularSliderWidget(
                    totalDuration: totalDuration,
                    position: position,
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.songName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.artistName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (playing == false) {
                              icon = Icons.pause;
                              playing = true;
                              playAudio();
                            } else if (playing == true) {
                              icon = Icons.play_arrow;
                              playing = false;
                              pauseAudio();
                            } else {
                              icon = Icons.play_arrow;
                            }
                          });
                        },
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 45.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ProgressBar(
                    thumbColor: Colors.white,
                    thumbRadius: 7.0,
                    thumbGlowRadius: 15.0,
                    progressBarColor: Colors.white,
                    timeLabelTextStyle: TextStyle(
                      fontSize: 0.0,
                      color: Colors.white,
                    ),
                    buffered: position,
                    baseBarColor: Colors.white10,
                    bufferedBarColor: Colors.white,
                    progress: position == null ? Duration.zero : position,
                    total:
                        totalDuration == null ? Duration.zero : totalDuration,
                    onSeek: (duration) {
                      seeking(duration);
                    },
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularSliderWidget extends StatelessWidget {
  const CircularSliderWidget({
    Key key,
    @required this.totalDuration,
    @required this.position,
  }) : super(key: key);

  final Duration totalDuration;
  final Duration position;

  @override
  Widget build(BuildContext context) {
    String timer() {
      dynamic countSec =
          position == null ? 0 : position.inSeconds.remainder(60).toInt();
      dynamic countMin =
          position == null ? 0 : position.inMinutes.remainder(60).toInt();
      if (countSec < 10) {
        countSec = "0$countSec";
      }
      if (countMin < 10) {
        countMin = "0$countMin";
      }
      return "$countMin:$countSec";
    }

    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 280.0,
        angleRange: 360.0,
        customWidths: CustomSliderWidths(
          progressBarWidth: 6,
          trackWidth: 10,
          shadowWidth: 0,
        ),
        customColors: CustomSliderColors(
          trackColor: Colors.transparent,
          progressBarColor: Colors.white,
          dotColor: Colors.transparent,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
      ),
      min: 0,
      max: totalDuration == null ? 0.0 : totalDuration.inSeconds.toDouble(),
      initialValue: position == null ? 0.0 : position.inSeconds.toDouble(),
      innerWidget: (double value) {
        return Center(
          child: Text(
            totalDuration == null ? "00:00" : timer(),
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        );
      },
    );
  }
}
