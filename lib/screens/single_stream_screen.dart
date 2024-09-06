import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:flutter_rtsp_player/common/video_player_factory.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';
import 'package:flutter_rtsp_player/widgets/player_controls.dart';
import 'package:flutter_rtsp_player/widgets/realtime_clock.dart';

class SingleStreamScreen extends StatefulWidget {
  final RtspStream stream;

  SingleStreamScreen({required this.stream});

  @override
  State<StatefulWidget> createState() => _SingleStreamScreenState();
}

class _SingleStreamScreenState extends State<SingleStreamScreen> {
  late VideoPlayerController videoPlayerController;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerFactory.create();
    videoPlayerController.open(widget.stream.url);
    _playing = videoPlayerController.player.state.playing;
    videoPlayerController.player.stream.playing.listen((playing) {
      if (mounted) {
        setState(() {
          _playing = playing;
        });
      }
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playing ${widget.stream.title ?? widget.stream.url}')),
      body: Center(
          child: Stack(
        children: [
          Column(
            children: [
              // RTSP video player goes here
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: videoPlayerController.build(context),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Text(
              widget.stream.title ?? "No title",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, backgroundColor: Colors.black54),
            ),
          ),
          Positioned(bottom: 72, right: 16, child: RealTimeClock(isUpdating: _playing)),
          Positioned(
            bottom: 8,
            left: 8,
            child: PlayerControls(videoPlayerController: videoPlayerController),
          ),
        ],
      )),
    );
  }
}
