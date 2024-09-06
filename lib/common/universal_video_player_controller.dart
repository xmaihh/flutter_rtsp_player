import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class UniversalVideoPlayerController implements VideoPlayerController {
  late final Player _player;
  late final VideoController _videoController;
  bool _isRecording = false;

  @override
  Player get player => _player;

  UniversalVideoPlayerController() {
    _player = Player();
    _videoController = VideoController(_player);
  }

  @override
  Future<void> open(String url) async {
    await _player.open(Media(url));
  }

  @override
  Widget build(BuildContext context, {Widget Function(VideoState)? controls}) {
    return Video(
      controller: _videoController,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.contain,
      controls: controls,
    );
  }

  @override
  Future<void> play() async {
    _player.play();
  }

  @override
  Future<void> pause() async {
    _player.pause();
  }

  @override
  Future<void> playOrPause() async {
    _player.playOrPause();
  }

  @override
  Future<void> seek(Duration position) async {
    _player.seek(position);
  }

  @override
  Future<void> startRecording() async {
    // Implement recording start logic here
    _isRecording = true;
    print("Recording started");
  }

  @override
  Future<void> stopRecording() async {
    // Implement recording stop logic here
    _isRecording = false;
    print("Recording stopped");
  }

  @override
  Future<Uint8List?> captureScreenshot() async {
    // Implement screenshot logic here
    return _player.screenshot();
    print("Screenshot taken");
  }

  @override
  Future<void> setVolume(double volume) async {
    _player.setVolume(volume);
  }

  @override
  Future<void> dispose() async {
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
  @override
  double get volume => _player.state.volume;
}
