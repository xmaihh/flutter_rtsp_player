import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:flutter_rtsp_player/common/video_player_factory.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';

class StreamPlayer extends StatefulWidget {
  final RtspStream stream;
  final bool showControls;

  StreamPlayer({
    required this.stream,
    this.showControls = false,
  });

  @override
  State<StreamPlayer> createState() => _StreamPlayerState();
}

class _StreamPlayerState extends State<StreamPlayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerFactory.create();
    videoPlayerController.open(widget.stream.url);
  }

  @override
  void didUpdateWidget(StreamPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stream.url != oldWidget.stream.url) {
      // 检查如果传递的参数有变化，更新内部状态
      videoPlayerController.open(widget.stream.url);
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Center(
            child: videoPlayerController.build(context),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Text(
            widget.stream.title ?? "No title",
            style: TextStyle(color: Colors.white, backgroundColor: Colors.black54),
          ),
        ),
        if (widget.showControls)
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () {
                    // 实现音量调节逻辑
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fullscreen, color: Colors.white),
                  onPressed: () {
                    // 实现全屏逻辑
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
