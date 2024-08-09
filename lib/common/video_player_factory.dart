// lib/common/video_player_factory.dart
import 'dart:io' show Platform; // Import this for platform detection

import 'package:flutter/foundation.dart' show kIsWeb;

import 'custom_video_player_controller.dart';
import 'video_player_controller_mobile.dart';
import 'video_player_controller_web.dart';
import 'video_player_controller_windows.dart'; // Always import, but only use if needed

class VideoPlayerFactory {
  static CustomVideoPlayerController create({required String url}) {
    if (kIsWeb) {
      return WebVideoPlayerController(url: url);
    } else if (Platform.isAndroid || Platform.isIOS) {
      return MobileVideoPlayerController(url: url);
    } else {
      // Default to medit-kit
      return WindowsVideoPlayerController(url: url);
    }
  }
}
