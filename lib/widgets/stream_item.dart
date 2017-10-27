import 'package:flutter/material.dart';
import '../models/rtsp_stream.dart';
import '../screens/player_screen.dart';

class StreamItem extends StatelessWidget {
  final RtspStream stream;

  StreamItem({required this.stream});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stream.url),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerScreen(streamUrl: stream.url),
          ),
        );
      },
    );
  }
}
