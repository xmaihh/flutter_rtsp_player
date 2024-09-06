import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/screens/single_stream_screen.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';

import '../models/rtsp_stream.dart';
import '../services/rtsp_service.dart';

class StreamItem extends StatefulWidget {
  final RtspStream stream;
  final bool showDeleteButton;
  final bool isSelectionMode;
  final bool isSelected;
  final void Function(bool, RtspStream) onStreamSelectionChanged;

  const StreamItem({super.key, required this.stream, required this.showDeleteButton, required this.isSelectionMode, required this.isSelected, required this.onStreamSelectionChanged});

  @override
  State<StatefulWidget> createState() => _StreamItemState();
}

class _StreamItemState extends State<StreamItem> {
  Uint8List? _thumbnailBytes;
  bool _isLoading = false;
  Player? _player;

  @override
  void initState() {
    super.initState();
    // 延迟加载预览图
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadThumbnail();
      }
    });
  }

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(widget.stream.url),
      title: Text(
        widget.stream.title ?? 'No title',
        style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
      ),
      leading: SizedBox(
        width: 100,
        height: 56.0,
        child: _thumbnailBytes != null
            ? Image.memory(_thumbnailBytes!, fit: BoxFit.cover)
            : _isLoading
                ? const Center(child: CircularProgressIndicator())
                : const Icon(Icons.video_library),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.isSelectionMode)
            Checkbox(
              value: widget.isSelected,
              onChanged: (value) => widget.onStreamSelectionChanged(value!, widget.stream),
            ),
          if (widget.showDeleteButton && !widget.isSelectionMode)
            IconButton(
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
                  Provider.of<RtspService>(context, listen: false).removeStream(widget.stream);
                }
              },
            ),
        ],
      ),
      onTap: widget.isSelectionMode
          ? () => widget.onStreamSelectionChanged(!widget.isSelected, widget.stream)
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleStreamScreen(stream: widget.stream),
                ),
              );
            },
    );
  }

  Future<void> _loadThumbnail() async {
    if (_isLoading || _thumbnailBytes != null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      _player ??= Player()
      ..setVolume(0);
      await _player!.open(Media(widget.stream.url));
      
      final _controller = VideoController(_player!);
      await _controller.waitUntilFirstFrameRendered;
      final bytes = await _player!.screenshot(format: 'image/jpeg');
      debugPrint("预览图大小bytes：${bytes?.length}");
      await _controller.player.pause();
      if (mounted) {
        setState(() {
          _thumbnailBytes = bytes;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading thumbnail: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } finally {
      await _player?.dispose();
      _player = null;
    }
  }
}
