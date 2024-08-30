import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';
import 'package:flutter_rtsp_player/screens/multi_stream_screen.dart';
import 'package:flutter_rtsp_player/services/rtsp_service.dart';
import 'package:flutter_rtsp_player/widgets/stream_item.dart';
import 'package:provider/provider.dart';

import 'add_rtsp_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RtspStream> selectedStreams = [];
  bool showDeleteButton = false;
  bool isSelectionMode = false;

  void toggleStreamSelection(RtspStream rtspStream) {
    setState(() {
      if (selectedStreams.contains(rtspStream)) {
        selectedStreams.remove(rtspStream);
      } else {
        selectedStreams.add(rtspStream);
      }
    });
  }

  void toggleSelectionMode() {
    setState(() {
      isSelectionMode = !isSelectionMode;
      if (!isSelectionMode) {
        selectedStreams.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RtspService>(builder: (context, rtspService, child) {
      final streams = rtspService.streams;
      return Scaffold(
        appBar: _buildAppbar(),
        body: streams.isEmpty ? const Center(child: Text('No streams available')) : _buildStreamList(streams),
        floatingActionButton: selectedStreams.isEmpty ? _buildAddRtspButton() : _buildMultiStreamButton(selectedStreams),
      );
    });
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text('RTSP Streams'),
      actions: [
        IconButton(
          icon: Icon(isSelectionMode ? Icons.close : Icons.select_all),
          onPressed: toggleSelectionMode,
        ),
        if (isSelectionMode) Text('${selectedStreams.length} selected', style: TextStyle(fontSize: 16)),
        PopupMenuButton<String>(
          onSelected: (String result) {
            setState(() {
              switch (result) {
                case 'toggleDelete':
                  showDeleteButton = !showDeleteButton;
                  break;
              }
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            CheckedPopupMenuItem<String>(
              checked: showDeleteButton,
              value: 'toggleDelete',
              child: Text('Show Delete Button'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStreamList(List<RtspStream> _streams) {
    return ListView.builder(
        itemCount: _streams.length,
        itemBuilder: (context, index) {
          return StreamItem(stream: _streams[index], showDeleteButton: showDeleteButton, isSelectionMode: isSelectionMode, isSelected: selectedStreams.contains(_streams[index]), onStreamSelectionChanged: (_, stream) => toggleStreamSelection(stream));
        });
  }

  Widget _buildAddRtspButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddRtspScreen()),
        );
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildMultiStreamButton(List<RtspStream> selectedStreams) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MultiStreamScreen(selectedStreams: selectedStreams)),
      ),
      label: Text('Play Selected'),
      icon: Icon(Icons.play_arrow),
    );
  }
}
