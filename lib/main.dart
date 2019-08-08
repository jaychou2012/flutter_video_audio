import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'ui/audio_page.dart';
import 'ui/video_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Video Audio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text("播放视频"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VideoPage();
                  }));
                }),
            RaisedButton(
                child: Text("播放音频"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AudioPage();
                  }));
                }),
          ],
        ),
      ),
    );
  }
}
