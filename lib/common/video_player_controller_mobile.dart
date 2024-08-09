import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'custom_video_player_controller.dart';

class MobileVideoPlayerController implements CustomVideoPlayerController {
  final String url;
  late VlcPlayerController _vlcPlayerController;

  MobileVideoPlayerController({required this.url}) {
    _vlcPlayerController = VlcPlayerController.network(
      url,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  Widget buildVideoPlayer(BuildContext context) {
    return VlcPlayer(
      controller: _vlcPlayerController,
      aspectRatio: 16 / 9,
      placeholder: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.stop();
    _vlcPlayerController.dispose();
  }

  @override
  void pause() {
    _vlcPlayerController.pause();
  }

  @override
  void play() {
    _vlcPlayerController.play();
  }
}