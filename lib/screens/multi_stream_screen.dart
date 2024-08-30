import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';
import 'package:flutter_rtsp_player/widgets/stream_player.dart';

class MultiStreamScreen extends StatefulWidget {
  final List<RtspStream> selectedStreams;

  MultiStreamScreen({required this.selectedStreams});

  @override
  State<MultiStreamScreen> createState() => _MultiStreamScreenState();
}

class _MultiStreamScreenState extends State<MultiStreamScreen> {
  RtspStream? activeStream;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final columns = isLandscape ? 3 : 2;

    return Scaffold(
        appBar: AppBar(
          title: Text('Multiple Streams'),
          actions: [
            IconButton(
              icon: Icon(activeStream != null ? Icons.grid_view : Icons.fullscreen),
              onPressed: () {
                setState(() {
                  activeStream = activeStream != null ? null : widget.selectedStreams.first;
                });
              },
            ),
          ],
        ),
        body: activeStream == null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: 0,
                  mainAxisSpacing:0,
                ),
                itemCount: widget.selectedStreams.length,
                itemBuilder: (context, index) {
                  final stream = widget.selectedStreams[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        activeStream = stream;
                      });
                    },
                    child:  Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                        child: StreamPlayer(
                          stream: stream,
                          showControls: false,
                        ),
                      ),
                  );
                },
              )
            : Row(
                children: [
                  Expanded(
                    flex: isLandscape ? 3 : 2,
                    child: StreamPlayer(
                      stream: widget.selectedStreams.firstWhere((s) => s == activeStream),
                      showControls: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: widget.selectedStreams.length,
                      itemBuilder: (context, index) {
                        final stream = widget.selectedStreams[index];
                        return GestureDetector(
                          onTap: () {
                            debugPrint("点击了： ${stream.url}");
                            setState(() {
                              activeStream = stream;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: stream == activeStream ? Colors.blue : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: StreamPlayer(stream: stream, showControls: false),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ));
  }
}

class RTSPPlayerWidget extends StatelessWidget {
  final RtspStream stream;
  final bool showControls;

  RTSPPlayerWidget({
    required this.stream,
    this.showControls = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          child: Center(
            child: Text(
              'RTSP Stream $stream',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Text(
            stream.title ?? "No title",
            style: TextStyle(color: Colors.white, backgroundColor: Colors.black54),
          ),
        ),
        if (showControls)
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () {
                    // 实现音量调节逻辑
                  },
                ),
                IconButton(
                  icon: Icon(Icons.fullscreen, color: Colors.white),
                  onPressed: () {
                    // 实现全屏逻辑
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
