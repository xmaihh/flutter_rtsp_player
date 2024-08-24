import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';

import '../common/video_player_factory.dart';
import '../models/rtsp_stream.dart';
import '../widgets/player_controls.dart';

class PlayerScreen extends StatefulWidget {
  final RtspStream stream;

  PlayerScreen({required this.stream});

  @override
  State<StatefulWidget> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerFactory.create(url: widget.stream.url);
    videoPlayerController.initialize();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playing ${widget.stream.url}'),
      ),
      body: Center(
        child: Column(
          children: [
            // RTSP video player goes here
            Expanded(
              child: Container(
                color: Colors.black,
                // Use a package like video_player or flutter_vlc_player
                // to implement RTSP streaming
                child:
                    // VlcPlayer(
                    //   controller: _vlcPlayerController,
                    //   aspectRatio: 16 / 9,
                    //   placeholder: Center(child: CircularProgressIndicator()),
                    // ),
                    videoPlayerController.build(context),
              ),
            ),
            PlayerControls(videoPlayerController: videoPlayerController),
          ],
        ),
      ),
    );
  }
}
