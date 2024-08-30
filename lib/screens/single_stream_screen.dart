import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:flutter_rtsp_player/common/video_player_factory.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';
import 'package:flutter_rtsp_player/widgets/player_controls.dart';

class SingleStreamScreen extends StatefulWidget {
  final RtspStream stream;

  SingleStreamScreen({required this.stream});

  @override
  State<StatefulWidget> createState() => _SingleStreamScreenState();
}

class _SingleStreamScreenState extends State<SingleStreamScreen> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerFactory.create();
    videoPlayerController.open(widget.stream.url);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playing ${widget.stream.title??widget.stream.url}')),
      body: Center(
        child:
        Stack(
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
                PlayerControls(videoPlayerController: videoPlayerController),
              ],
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Text(
                widget.stream.title ?? "No title",
                style: TextStyle(color: Colors.white, backgroundColor: Colors.black54),
              ),
            ),
          ],
        )
      ),
    );
  }
}
