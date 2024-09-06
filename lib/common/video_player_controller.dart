import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

abstract class VideoPlayerController {
  Player get player;

  Widget build(BuildContext context, {Widget Function(VideoState)? controls});

  Future<void> open(String url);

  Future<void> play();

  Future<void> pause();

  Future<void> playOrPause();

  Future<void> seek(Duration position);

  Future<void> startRecording();

  Future<void> stopRecording();

  Future<Uint8List?> captureScreenshot();

  Future<void> setVolume(double volume);

  Future<void> dispose();

  double get volume;
// Duration get currentPosition;
// Duration get totalDuration;
// bool get isPlaying;
}
