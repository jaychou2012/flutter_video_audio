import 'package:flutter/material.dart';
import 'package:flutter_video_audio/widgets/audio_widget.dart';

class AudioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AudioPageState();
  }
}

class AudioPageState extends State<AudioPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromRGBO(16, 33, 141, 1),
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.format_align_right,
                color: Color.fromRGBO(16, 33, 141, 1),
              ),
              onPressed: () {}),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 6,
                    child: Image.network(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565282601801&di=b5a4bc8cb5e3853ac0cb864a328fc7cd&imgtype=0&src=http%3A%2F%2Fimg.univs.cn%2F20150630%2F0%2F201506301629325505073940.jpg",
                      width: MediaQuery.of(context).size.width - 60,
                    ),
                  ),
                ),
                Text(
                  '最好听的歌',
                  style: TextStyle(
                      color: Color.fromRGBO(16, 33, 141, 1), fontSize: 26),
                ),
                Text(
                  '歌手名',
                  style: TextStyle(
                      color: Color.fromRGBO(154, 160, 174, 1), fontSize: 20),
                ),
              ],
            )),
            AudioWidget(),
          ],
        ),
      ),
    );
  }
}
