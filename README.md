# flutter_video_audio
 flutter_video_audio
 
  Flutter Dart QQ技术交流群：979966470
  
音视频部分其实也不是很难，对于原生Android平台，Google有ExoPlayer，支持常见的很多种视频格式和协议，性能、功能和稳定性也非常的好。其他平台也都有各自的播放器API。Flutter本身目前的API并不支持音视频播放处理，毕竟无法达到原生播放器的体验和效果。所以官方的插件库也都是分别调用和封装原生播放器进行的API交互处理，本质都是使用的原生播放器进行播放处理。

我们的视频播放器将要使用的就是官方的video_player 插件库：https://pub.dev/packages/video_player

官方例子效果图：

![官方例子效果图](https://github.com/jaychou2012/flutter_video_audio/blob/master/screenshot/demo_ipod.gif?raw=true)


音频播放器部分我们使用第三方插件库AudioPlayers ：https://pub.dev/packages/audioplayers ，这个插件库也是调用的原生播放，只不过封装了一层API。我们也可以自己写插件，基于原生的一些播放器API进行封装。
这个audioplayers插件也是原生分别对应：
* Android平台：MediaPlayer；
* IOS平台：AVAudioPlayer

视频播放器将要使用的就是官方的video_player 插件库：https://pub.dev/packages/video_player

**本质就是分别对应调用的就是：**
* Android平台：ExoPlayer
* IOS平台：AVPlayer

做过Android或IOS原生开发的应该对这两个播放器库都非常的熟悉。ExoPlayer是Google官方推出的一个播放器库，非常的强大。AVPlayer是IOS平台的原生播放器库。
那么video_player插件库就是基于这两个原生播放器进行插件封装API。

**支持的格式：**
所支持的视频格式和协议也就是ExoPlayer和AVPlayer所对应支持的格式。

视频播放器所支持的视频播放地址流主要由三大部分组成：
1、视频/音频流协议（如：http，https，rtsp，rtmp，hls）
2、视频/音频编码格式（如：h264，h265，aac，pcm，mp3，wma）
3、视频/音频封装格式（如：.mp4，.mp3，.flv，.ts，.m3u8）

具体Android平台的ExoPlayer支持的格式，大家可以看官方文档：https://exoplayer.dev/supported-formats.html，这里不再列举，大部分的都是支持的。还可以通过FFmpeg extension这个ExoPlayer的官方扩展库，来扩展更多音视频编解码功能。

苹果IOS平台的AVPlayer支持的格式、协议也非常的丰富，大家自行网络查询了解。

其实ExoPlayer和AVPlayer也可以作为音频播放器，这都是没问题的。也就是video_player也可以兼容作为音频播放器。

我们先看下视频播放器的效果图：

![视频播放器的效果图](https://github.com/jaychou2012/flutter_video_audio/blob/master/screenshot/gifhome_540x960_25s.gif?raw=true)


![视频播放器的效果图](https://github.com/jaychou2012/flutter_video_audio/blob/master/screenshot/device-2019-08-07-224424.png?raw=true)


![视频播放器的效果图](https://github.com/jaychou2012/flutter_video_audio/blob/master/screenshot/device-2019-08-07-224450.png?raw=true)

**视频播放器实现了：全屏半屏切换，控制操作栏的显示与隐藏，播放和暂停，进度时时显示，播放时长和总时长的格式化显示，手势操作的一部分等功能。**


音频播放器部分我们使用第三方插件库AudioPlayers ：https://pub.dev/packages/audioplayers ，这个插件库也是调用的原生播放，只不过封装了一层API。我们也可以自己写插件，基于原生的一些播放器API进行封装。
这个audioplayers插件对应的原生调用分别是：
* Android平台：MediaPlayer
* IOS平台：AVAudioPlayer

接下来我们看下我们实现的效果图：


![音频播放器的效果图](https://github.com/jaychou2012/flutter_video_audio/blob/master/screenshot/gifhome_540x960_7s.gif?raw=true)

静态效果图：

![音频播放器的效果图](https://github.com/jaychou2012/flutter_video_audio/blob/master/screenshot/device-2019-08-08-233521.png?raw=true)


**音频播放器实现了：播放、暂停、停止销毁、进度时时显示、播放时长和总时长的格式化显示，状态监听、支持播放网络音频文件、本地音频文件、资源目录音频文件。**


## 《从零开始学Flutter》已出版


### 新书涵盖Flutter最新的大部分的组件技术和内容，从零开始深入讲解其中涉及的技术点，包括：Dart基础 、Flutter基础组件、Flutter开发规范、路由与生命周期、Http网络请求、应用打包与发布等，值得购买阅读。


![从零开始学Flutter](https://img10.360buyimg.com/n1/jfs/t1/150105/31/6483/200868/5f448b12E10484765/20a772cdd2d0a857.jpg "从零开始学Flutter")


### 纸质书购买：

[京东](https://item.jd.com/10020767293895.html "京东")         [天猫](https://detail.tmall.com/item.htm?spm=a220m.1000858.1000725.46.4d964d77KORSb8&id=625677553628&areaId=500100&user_id=1932014659&cat_id=2&is_b=1&rn=cfb373631608a3f9e449fc0a225a090d "天猫")  [当当](http://product.dangdang.com/1675961491.html "当当")
