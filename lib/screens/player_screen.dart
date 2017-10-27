import 'package:flutter/material.dart';
import '../widgets/player_controls.dart';

class PlayerScreen extends StatelessWidget {
  final String streamUrl;

  PlayerScreen({required this.streamUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RTSP Player'),
      ),
      body: Center(
        child: Column(
          children: [
            // RTSP video player goes here
            Expanded(
              child: Container(
                color: Colors.black,
                // Use a package like video_player or flutter_vlc_player
                // to implement RTSP streaming
              ),
            ),
            PlayerControls(),
          ],
        ),
      ),
    );
  }
}
