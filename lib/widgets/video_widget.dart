import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_audio/utils/utils.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoWidgetState();
  }
}

class VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  int position = 0;
  double height = 0;
  bool fullScreen = false;
  bool hideAppBar = false;
  bool hideControllBar = false;
  String tips = '缓冲中...';
  IconData _icons = Icons.pause_circle_outline;
  double dy = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://media.w3.org/2010/05/sintel/trailer.mp4');
    _controller.addListener(() {
      if (_controller.value.hasError) {
        print(_controller.value.errorDescription);
        setState(() {
          tips = '播放出错';
        });
      } else if (_controller.value.initialized) {
        setState(() {
          position = _controller.value.position.inSeconds;
          tips = '';
        });
      } else if (_controller.value.isBuffering) {
        setState(() {
          tips = '缓冲中...';
        });
      }
    });
    _controller.initialize().then((_) {
      setState(() {
        _controller.play();
        _controller.setVolume(1);
      });
    });
    _controller.setLooping(true);
    height = 200;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // 编写onWillPop逻辑
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: getAppBar(),
            body: Container(
              color: Colors.black,
              height: height,
              child: _controller.value.initialized
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: InkWell(
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                // 滑动控制音量、亮度、进度等操作
                                GestureDetector(
                                  onVerticalDragStart: (details) {
                                    dy = 0;
                                  },
                                  onVerticalDragUpdate: (details) {
                                    dy += details.delta.dy;
                                    print('${details.delta.dy}  :  $dy');
                                    print(dy /
                                        MediaQuery.of(context).size.height);
                                    _controller.setVolume(1);
                                  },
                                  onVerticalDragEnd: (details) {},
                                  child: VideoPlayer(_controller),
                                ),
                                Text(
                                  tips,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                hideControllBar = !hideControllBar;
                              });
                            },
                          ),
                        ),
                        // 播放器顶部标题栏
                        Align(
                          alignment: Alignment.topCenter,
                          child: Offstage(
                            offstage: hideControllBar,
                            child: Container(
                              color: Colors.black38,
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (fullScreen) {
                                          height = 200;
                                          SystemChrome
                                              .setPreferredOrientations([
                                            DeviceOrientation.portraitUp,
                                            DeviceOrientation.portraitUp,
                                          ]);
                                          SystemChrome
                                              .setEnabledSystemUIOverlays([
                                            SystemUiOverlay.top,
                                            SystemUiOverlay.bottom
                                          ]);
                                          hideAppBar = false;
                                        } else {
                                          print('关闭');
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '标题',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // 播放器底部控制栏
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Offstage(
                            offstage: hideControllBar,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              color: Colors.black54,
                              child: Row(children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                        _icons = Icons.play_circle_outline;
                                      } else {
                                        _controller.play();
                                        _icons = Icons.pause_circle_outline;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    _icons,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  TimeUtils.getCurrentPosition(position),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // 进度条
                                Expanded(
                                    child: LinearProgressIndicator(
                                  value: TimeUtils.getProgress(position,
                                      _controller.value.duration.inSeconds),
                                  backgroundColor: Colors.black87,
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  TimeUtils.getCurrentPosition(
                                      _controller.value.duration.inSeconds),
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onTap: () {
                                    fullOrMin();
                                  },
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Text(
                        tips,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
            )));
  }

  Widget getAppBar() {
    return PreferredSize(
        // Offstage来控制AppBar的显示与隐藏
        child: Offstage(
          offstage: hideAppBar,
          child: AppBar(
            title: Text('VideoPlayer'),
            primary: true,
          ),
        ),
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07));
  }

  // 返回键拦截执行方法
  Future<bool> _onWillPop() {
    if (fullScreen) {
      setState(() {
        height = 200;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        hideAppBar = false;
        fullScreen = !fullScreen;
      });
      return Future.value(false); //不退出
    } else {
      return Future.value(true); //退出
    }
  }

  void fullOrMin() {
    setState(() {
      if (fullScreen) {
        height = 200;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        hideAppBar = false;
      } else {
        hideAppBar = true;
        height = MediaQuery.of(context).size.height;
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeLeft,
        ]);
        SystemChrome.setEnabledSystemUIOverlays([]);
      }
      fullScreen = !fullScreen;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }
}
