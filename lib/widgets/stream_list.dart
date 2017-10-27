import 'package:flutter/material.dart';
import '../services/rtsp_service.dart';
import 'stream_item.dart';

class StreamList extends StatelessWidget {
  final RtspService _rtspService = RtspService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _rtspService.streams.length,
      itemBuilder: (context, index) {
        final stream = _rtspService.streams[index];
        return StreamItem(stream: stream);
      },
    );
  }
}
