import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';
import 'package:flutter_rtsp_player/widgets/player_controls.dart';
import 'package:flutter_rtsp_player/widgets/realtime_clock.dart';

class StreamPlayer extends StatefulWidget {
  final RtspStream stream;
  final bool showControls;
  final VideoPlayerController videoPlayerController;

  StreamPlayer({
    required this.stream,
    required this.videoPlayerController,
    this.showControls = false,
  });

  @override
  State<StreamPlayer> createState() => _StreamPlayerState();
}

class _StreamPlayerState extends State<StreamPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(StreamPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.stream.url != oldWidget.stream.url) {
      // 检查如果传递的参数有变化，更新内部状态
      widget.videoPlayerController.open(widget.stream.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Center(
            child: widget.videoPlayerController.build(context),
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
            child: PlayerControls(videoPlayerController: widget.videoPlayerController,volumeSliderSize: 85,),
          ),
      ],
    );
  }
}
