import 'package:flutter_rtsp_player/common/universal_video_player_controller.dart';

import 'video_player_controller.dart';

class VideoPlayerFactory {
  static VideoPlayerController create({required String url}) {
    // Default to medit-kit
    return UniversalVideoPlayerController(url: url);
  }
}
