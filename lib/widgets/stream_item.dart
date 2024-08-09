import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/rtsp_stream.dart';
import '../screens/player_screen.dart';
import '../services/rtsp_service.dart';

class StreamItem extends StatelessWidget {
  final RtspStream stream;

  const StreamItem({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stream.url),
      subtitle: Text(stream.username ?? 'No username'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          // Show confirmation dialog
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete Stream'),
              content: Text('Are you sure you want to delete this stream?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Delete'),
                ),
              ],
            ),
          );

          // If confirmed, proceed with deletion
          if (confirmed == true) {
            Provider.of<RtspService>(context, listen: false).removeStream(stream);
          }
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerScreen(stream: stream),
          ),
        );
      },
    );
  }
}
