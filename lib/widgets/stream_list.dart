import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/rtsp_service.dart';
import 'stream_item.dart';

class StreamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RtspService>(builder: (context, rtspService, child) {
      final streams = rtspService.streams;

      if (streams.isEmpty) {
        return const Center(child: Text('No streams available'));
      }
      return ListView.builder(
        itemCount: rtspService.streams.length,
        itemBuilder: (context, index) {
          final stream = rtspService.streams[index];
          return StreamItem(stream: stream);
        },
      );
    });
  }
}
