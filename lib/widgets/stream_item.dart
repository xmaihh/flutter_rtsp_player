import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';

import '../models/rtsp_stream.dart';
import '../screens/player_screen.dart';
import '../services/rtsp_service.dart';

class StreamItem extends StatefulWidget {
  final RtspStream stream;

  const StreamItem({super.key, required this.stream});

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
      title: Text(widget.stream.title ?? 'No title',style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),),
      leading: SizedBox(
        width: 100,
        height: 56,
        child: _thumbnailBytes != null
            ? Image.memory(_thumbnailBytes!, fit: BoxFit.cover)
            : _isLoading
                ? const Center(child: CircularProgressIndicator())
                : const Icon(Icons.video_library),
      ),
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
            Provider.of<RtspService>(context, listen: false).removeStream(widget.stream);
          }
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerScreen(stream: widget.stream),
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
      _player ??= Player();
      await _player!.open(Media(widget.stream.url));

      // 等待一小段时间确保视频已加载
      await Future.delayed(const Duration(milliseconds: 10500));

      final bytes = await _player!.screenshot(format: 'image/jpeg');
      print("bytes：${bytes?.length}");
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
