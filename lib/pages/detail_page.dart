import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:melophile/uitools/const.dart';
import 'package:melophile/widgets/custom_button_widget.dart';
import 'package:provider/provider.dart';

class AudioFIle extends ChangeNotifier {
  String path = '';
  Duration totalDuration = new Duration();
  Duration position = new Duration();
  String audioState = '';

  AudioFIle({required this.path}) {
    initAudio();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.STOPPED) audioState = "Stopped";
      if (playerState == PlayerState.PLAYING) audioState = "Playing";
      if (playerState == PlayerState.PAUSED) audioState = "Paused";
      if (playerState == PlayerState.COMPLETED) {
        stopAudio();
        audioState = "Paused";
      }
      notifyListeners();
    });
  }

  playAudio() {
    audioPlayer.play(path);
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  stopAudio() {
    audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }
}

class DetailPage extends StatefulWidget {
  String audioPath = '';
  String songName = '';
  String albumName = '';
  String profileImg = '';

  DetailPage(
      {required this.songName,
      required this.audioPath,
      required this.albumName,
      required this.profileImg});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  double sliderValue = 0;
  var _value;
  late AnimationController _controller;
  var isPlay;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _value = 0.0;
    isPlay = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String audioPath = widget.audioPath;
    String songName = widget.songName;
    String albumName = widget.albumName;
    String profileImg = widget.profileImg;

//
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => AudioFIle(path: audioPath),
        child: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomButtonWidget(
                        child:
                            Icon(Icons.arrow_back, color: AppColors.styleColor),
                        size: 50,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text(
                        "PLAYING NOW",
                        style: TextStyle(
                          color: AppColors.styleColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomButtonWidget(
                        child: Icon(Icons.menu, color: AppColors.styleColor),
                        size: 50,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                CustomButtonWidget(
                  child: Icon(
                    Icons.disc_full,
                    color: AppColors.styleColor.withAlpha(0),
                  ),
                  image: profileImg,
                  size: MediaQuery.of(context).size.width * .7,
                  borderWidth: 5,
                  onTap: () {},
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      songName,
                      style: TextStyle(
                        color: AppColors.styleColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 2,
                      ),
                    ),
                  ),
                ),
                Text(
                  albumName,
                  style: TextStyle(
                    color: AppColors.styleColor.withAlpha(90),
                    fontSize: 16,
                  ),
                ),
                Expanded(child: SizedBox()),
                Consumer<AudioFIle>(
                  builder: (_, AudioFIleModel, child) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AudioFIleModel.position.toString().split('.').first,
                        ),
                        Text(
                          AudioFIleModel.totalDuration
                              .toString()
                              .split('.')
                              .first,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: Colors.blueAccent.shade400,
                      inactiveTrackColor: Colors.blueAccent.withAlpha(50),
                      thumbColor: Colors.blue,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                      trackHeight: 5,
                    ),
                    child: Consumer<AudioFIle>(
                      builder: (_, AudioFIleModel, child) => Slider(
                        value: AudioFIleModel.position == null
                            ? 0
                            : AudioFIleModel.position.inMilliseconds.toDouble(),
                        onChanged: (sval) {
                          AudioFIleModel.seekAudio(
                              Duration(milliseconds: sval.toInt()));
                        },
                        min: 0,
                        max: AudioFIleModel.totalDuration == null
                            ? 20
                            : AudioFIleModel.totalDuration.inMilliseconds
                                .toDouble(),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 42,
                  ),
                  child: Consumer<AudioFIle>(
                    builder: (_, AudioFIleModel, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomButtonWidget(
                          child:
                              Icon(Icons.repeat, color: AppColors.styleColor),
                          size: 40,
                          onTap: () {},
                          borderWidth: 5,
                        ),
                        CustomButtonWidget(
                          child: Icon(Icons.skip_previous,
                              color: AppColors.styleColor),
                          size: 40,
                          onTap: () {},
                          borderWidth: 5,
                        ),
                        CustomButtonWidget(
                          size: 80,
                          onTap: () {
                            AudioFIleModel.stopAudio();
                            if (_controller.value == 0.0) {
                              AudioFIleModel.playAudio();
                              _controller.forward();
                              setState(() {
                                isPlay = false;
                              });
                            } else {
                              AudioFIleModel.pauseAudio();
                              _controller.reverse();
                              setState(() {
                                isPlay = true;
                              });
                            }
                          },
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _controller,
                            color: isPlay ? AppColors.styleColor : Colors.white,
                          ),
                          isActive: !isPlay,
                          borderWidth: 5,
                        ),
                        CustomButtonWidget(
                          child: Icon(Icons.skip_next,
                              color: AppColors.styleColor),
                          size: 40,
                          onTap: () {},
                          borderWidth: 5,
                        ),
                        CustomButtonWidget(
                          child:
                              Icon(Icons.shuffle, color: AppColors.styleColor),
                          size: 40,
                          onTap: () {},
                          borderWidth: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
