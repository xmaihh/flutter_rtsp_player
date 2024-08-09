import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'custom_video_player_controller.dart';

class WebVideoPlayerController implements CustomVideoPlayerController {
  final String url;
  late VideoPlayerController _videoPlayerController;

  WebVideoPlayerController({required this.url}) {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _videoPlayerController.play();
      });
  }

  @override
  Widget buildVideoPlayer(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: _videoPlayerController.value.isInitialized ? VideoPlayer(_videoPlayerController) : Container(),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
  }

  @override
  void pause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    }
  }

  @override
  void play() {
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.play();
    }
  }
}
