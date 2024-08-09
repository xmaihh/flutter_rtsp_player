import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'custom_video_player_controller.dart';

class WindowsVideoPlayerController implements CustomVideoPlayerController {
  final String url;
  late Player _player;
  late VideoController _videoController;

  WindowsVideoPlayerController({required this.url}) {
    _player = Player();
    _videoController = VideoController(_player);
    _player.open(Media(url));
  }

  @override
  Widget buildVideoPlayer(BuildContext context) {
    return Video(
      controller: _videoController,
      width: 640,
      height: 360,
      fit: BoxFit.contain,
    );
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
  }

  @override
  void pause() {
    _player.pause();
  }

  @override
  void play() {
    _player.play();
  }
}
