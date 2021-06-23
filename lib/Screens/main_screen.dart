import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:chat_screen/widgets/image_text_box.dart';
import 'package:chat_screen/widgets/text_message_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isPressed = false;
  late AudioPlayer _player;
  final url = 'https://bigsoundbank.com/UPLOAD/mp3/0160.mp3';
  late Stream<DurationState> _durationState;
  var _labelLocation = TimeLabelLocation.below;
  var _labelType = TimeLabelType.totalTime;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setUrl(url);
    } catch (e) {
      print("An error occured $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var minWidth = 100;

    return Scaffold(
      backgroundColor: Color(0xFF1c1b1b),
      body: Column(
        children: [
          Container(
            height: height / 15,
            width: width,
            color: Color(0xFF424543),
            child: Row(
              children: [
                SizedBox(
                  width: width / 50,
                ),
                CircleAvatar(
                  radius: 25,
                  child: Image.asset('assets/logos/image.png'),
                ),
                SizedBox(
                  width: width / 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height / 80,
                    ),
                    Text(
                      '/r/Telegram',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height / 180,
                    ),
                    Text('91 subscribers',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w100)),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width / 3,
              ),
              Container(
                height: height - (height / 15),
                width: width / 1.5,
                child: ListView(
                  reverse: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    ChatContainerWidget(height: height),
                    ChatContainerWidget(height: height),
                    ImageTextBox(
                      width: width,
                      height: height,
                      imageUrl: 'assets/logos/test2image.jpg',
                    ),
                    ImageTextBox(
                      width: width,
                      height: height,
                      imageUrl: 'assets/logos/testImage.png',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: Stack(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    minWidth: 100, maxWidth: 500),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black45,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width / 300,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            width: width / 45,
                                            height: width / 45,
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(180))),
                                            child: _playButton(),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0.5,
                                            child: GestureDetector(
                                              onTap: () {
                                                print('pressed');
                                              },
                                              child: Container(
                                                width: width / 110,
                                                height: width / 110,
                                                decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(180),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 3.0,
                                                          spreadRadius: 0.0,
                                                          offset: Offset(0, 0))
                                                    ]),
                                                child: Icon(
                                                  Icons.download_sharp,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width / 100,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Legacy',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: height / 300,
                                          ),
                                          Container(
                                              width: width / 10,
                                              child: _progressBar()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 15,
                                bottom: 4.5,
                                child: Text(
                                  '10:30',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder<PlayerState>(
      stream: _player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: EdgeInsets.all(8.0),
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(),
          );
        } else if (playing != true) {
          return Center(
            child: IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 23.0,
              color: Colors.white,
              onPressed: _player.play,
            ),
          );
        } else if (processingState != ProcessingState.completed) {
          return IconButton(
            icon: Icon(Icons.pause),
            iconSize: 23.0,
            onPressed: _player.pause,
            color: Colors.white,
          );
        } else {
          return IconButton(
            icon: Icon(Icons.replay),
            iconSize: 23.0,
            color: Colors.white,
            onPressed: () {
              _player.seek(Duration.zero);
              _player.play();
            },
          );
        }
      },
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    _durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        _player.positionStream,
        _player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    return StreamBuilder<DurationState>(
      stream: _durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          progressBarColor: Colors.deepPurple,
          bufferedBarColor: Colors.grey.withOpacity(0.24),
          thumbColor: Colors.deepPurple,
          barHeight: 3.0,
          thumbRadius: 6.5,
          baseBarColor: Colors.grey.withOpacity(0.2),
          timeLabelTextStyle:
              TextStyle(color: Colors.white, fontSize: 10, height: 1.5),
          onSeek: (duration) {
            _player.seek(duration);
          },
          timeLabelLocation: _labelLocation,
          timeLabelType: _labelType,
        );
      },
    );
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });
  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
