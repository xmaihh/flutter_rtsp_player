import 'package:flutter/material.dart';
import 'add_rtsp_screen.dart';
import '../widgets/stream_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RTSP Streams'),
      ),
      body: StreamList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRtspScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
