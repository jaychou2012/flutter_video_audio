import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_audio/utils/utils.dart';

class AudioWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AudioWidgetState();
  }
}

class AudioWidgetState extends State<AudioWidget> {
  // 用来播放assets目录的音频文件，拷贝后当成本地文件播放
  static AudioCache player;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _duration = Duration();
  Duration _currentDuration = Duration();
  IconData _icons = Icons.pause_circle_filled;

  var kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
  var kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
  var kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';
  bool playing = false;

  @override
  void initState() {
    super.initState();
    player = AudioCache(fixedPlayer: audioPlayer);
    //是否打印日志
    AudioPlayer.logEnabled = true;
    //设置地址，并不播放，调用player.resume开始播放
//    audioPlayer.setUrl(kUrl1, isLocal: false);

    // 播放本地音频
//    Future<Directory> _externalDocumentsDirectory =
//        getExternalStorageDirectory().then((Directory directory) {
//      print('${directory.path}/gbqq.mp3');
//      playLocal('${directory.path}/gbqq.mp3');
//    });

    // 播放assets目录音频
    player.play('audios/gbqq.mp3').then((AudioPlayer assetsAudioPlayer) {});

    //播放网络音频
//    play(kUrl1);

    //播放状态改变
    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState playerState) {
      if (playerState == AudioPlayerState.COMPLETED) {
      } else if (playerState == AudioPlayerState.PAUSED) {
        setState(() {
          playing = false;
        });
      } else if (playerState == AudioPlayerState.PLAYING) {
        setState(() {
          playing = true;
        });
      } else if (playerState == AudioPlayerState.STOPPED) {}
    });
    //播放音频总时长
    audioPlayer.onDurationChanged.listen((Duration d) {
      print('Max duration: $d');
      setState(() {
        _duration = d;
      });
    });
    //播放进度变化
    audioPlayer.onAudioPositionChanged.listen((Duration d) {
      setState(() {
        _currentDuration = d;
      });
    });
    //播放完成
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {});
    });
    // 播放出错
    audioPlayer.onPlayerError.listen((String error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Text(
                TimeUtils.getCurrentPosition(_currentDuration.inSeconds),
                style: TextStyle(
                  color: Color.fromRGBO(104, 112, 161, 1),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // 进度条
              Expanded(
                  child: LinearProgressIndicator(
                value: TimeUtils.getProgress(
                    _currentDuration.inSeconds, _duration.inSeconds),
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(115, 137, 186, 1)),
                backgroundColor: Color.fromRGBO(211, 211, 221, 1),
              )),
              SizedBox(
                width: 10,
              ),
              Text(
                TimeUtils.getCurrentPosition(_duration.inSeconds),
                style: TextStyle(
                  color: Color.fromRGBO(104, 112, 161, 1),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.skip_previous,
                  color: Color.fromRGBO(111, 135, 199, 1),
                  size: 40,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 60,
                alignment: Alignment.center,
                icon: Icon(
                  _icons,
                  color: Color.fromRGBO(111, 135, 199, 1),
                  size: 60,
                ),
                onPressed: () {
                  playOrPause();
                },
              ),
              IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.skip_next,
                  color: Color.fromRGBO(111, 135, 199, 1),
                  size: 40,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  play(String url) async {
    int result = await audioPlayer.play(url);
    print('播放状态：$result');
    if (result == 1) {
      // success
    } else {}
  }

  playLocal(String localPath) async {
    int result = await audioPlayer.play(localPath, isLocal: true);
    print('播放状态：$result');
    if (result == 1) {
      // success
    } else {}
  }

  playOrPause() {
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      setState(() {
        _icons = Icons.play_circle_filled;
        audioPlayer.pause();
      });
    } else {
      setState(() {
        _icons = Icons.pause_circle_filled;
        audioPlayer.resume();
      });
    }
    playing = !playing;
  }

  @override
  void dispose() {
    super.dispose();
    player.clear('audios/gbqq.mp3');
    player.fixedPlayer.stop();
    player.fixedPlayer.release();
    player.fixedPlayer.dispose();
    audioPlayer.stop();
    audioPlayer.release();
    audioPlayer.dispose();
  }
}
