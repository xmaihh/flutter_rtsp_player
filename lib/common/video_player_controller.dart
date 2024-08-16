import 'package:flutter/material.dart';

abstract class VideoPlayerController {
  Widget buildVideoPlayer(BuildContext context);

  Future<void> initialize();

  void play();

  void pause();

  void seek(Duration position);

  void startRecording();

  void stopRecording();

  Future<void> takeScreenshot();

  void setVolume(double volume);

  void dispose();
// Duration get position;
// Duration get duration;
// bool get isPlaying;
// double get volume;
}
