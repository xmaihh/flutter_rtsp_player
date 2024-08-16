import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class UniversalVideoPlayerController implements VideoPlayerController {
  final String url;
  late final Player _player;
  late final VideoController _videoController;
  bool _isRecording = false;

  UniversalVideoPlayerController({required this.url}) {
    _player = Player();
    _videoController = VideoController(_player);
  }

  @override
  Future<void> initialize() async {
    await _player.open(Media(url));
  }

  @override
  Widget buildVideoPlayer(BuildContext context) {
    return Video(
      controller: _videoController,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.contain,
    );
  }

  @override
  void play() {
    _player.play();
  }

  @override
  void pause() {
    _player.pause();
  }

  @override
  void seek(Duration position) {
    _player.seek(position);
  }

  @override
  void startRecording() {
    // Implement recording start logic here
    _isRecording = true;
    print("Recording started");
  }

  @override
  void stopRecording() {
    // Implement recording stop logic here
    _isRecording = false;
    print("Recording stopped");
  }

  @override
  Future<void> takeScreenshot() async {
    // Implement screenshot logic here
    _player.screenshot();
    print("Screenshot taken");
  }

  @override
  void setVolume(double volume) {
    _player.setVolume(volume);
  }

  @override
  void dispose() {
    _player.dispose();
  }

  // @override
  // Duration get position => _player.stream.position;
  //
  // @override
  // Duration get duration => _player.duration;
  //
  // @override
  // bool get isPlaying => _player.state == PlayerState.playing;
  //
  // @override
  // double get volume => _player.volume;
}
