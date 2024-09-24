import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:flutter_rtsp_player/common/video_player_factory.dart';
import 'package:flutter_rtsp_player/models/rtsp_stream.dart';
import 'package:flutter_rtsp_player/widgets/stream_player.dart';

class MultiStreamScreen extends StatefulWidget {
  final List<RtspStream> selectedStreams;

  MultiStreamScreen({required this.selectedStreams});

  @override
  State<MultiStreamScreen> createState() => _MultiStreamScreenState();
}

class _MultiStreamScreenState extends State<MultiStreamScreen> {
  List<VideoPlayerController> videoPlayerControllers = [];
  RtspStream? activeStream;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    videoPlayerControllers = List.generate(widget.selectedStreams.length, (index) => VideoPlayerFactory.create());
    _initializePlayers();
  }

  Future<void> _initializePlayers() async {
    final futures = videoPlayerControllers.asMap().entries.map((entry) async {
      final i = entry.key;
      final vpc = entry.value;
      await vpc.open(widget.selectedStreams[i].url);
      await vpc.setVolume(0.0);
    }).toList();
    await Future.wait(futures);
  }

  Future<void> soloPlayerAtIndex(int currentIndex) async {
    for (int i = 0; i < videoPlayerControllers.length; i++) {
      await videoPlayerControllers[i].setVolume(i == currentIndex ? 100.0 : 0.0);
    }
  }

  Future<void> _muteAllPlayers() async {
    final futures = videoPlayerControllers.map((controller) => controller.setVolume(0.0)).toList();
    await Future.wait(futures);
  }

  @override
  void dispose() {
    for (var controller in videoPlayerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
                if (activeStream == null) {
                  _muteAllPlayers();
                } else {
                  soloPlayerAtIndex(activeIndex);
                }
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
                  mainAxisSpacing: 0,
                ),
                itemCount: widget.selectedStreams.length,
                itemBuilder: (context, index) {
                  final stream = widget.selectedStreams[index];
                  final control = videoPlayerControllers[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        activeStream = stream;
                        activeIndex = index;
                      });
                      if (activeStream == null) {
                        _muteAllPlayers();
                      } else {
                        soloPlayerAtIndex(activeIndex);
                      }
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: StreamPlayer(
                        stream: stream,
                        showControls: false,
                        videoPlayerController: control,
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
                      videoPlayerController: videoPlayerControllers[activeIndex],
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
                              activeIndex = index;
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
                              child: StreamPlayer(
                                stream: stream,
                                showControls: false,
                                videoPlayerController: videoPlayerControllers[index],
                              ),
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
