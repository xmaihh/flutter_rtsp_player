import 'package:flutter/material.dart';
import '../services/media_service.dart';

class PlayerControls extends StatelessWidget {
  final MediaService _mediaService = MediaService();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            // Implement play functionality
          },
        ),
        IconButton(
          icon: Icon(Icons.pause),
          onPressed: () {
            // Implement pause functionality
          },
        ),
        IconButton(
          icon: Icon(Icons.camera),
          onPressed: () {
            _mediaService.captureScreenshot();
          },
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {
            _mediaService.startRecording();
          },
        ),
        IconButton(
          icon: Icon(Icons.volume_up),
          onPressed: () {
            _mediaService.adjustVolume(0.5); // Example volume level
          },
        ),
      ],
    );
  }
}
