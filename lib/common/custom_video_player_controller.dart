import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/services/media_service.dart';

abstract class CustomVideoPlayerController{
  Widget buildVideoPlayer(BuildContext context);
  void play();
  void pause();
  void dispose();
}