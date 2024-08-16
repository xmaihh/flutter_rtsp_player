import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

class VideoThumbnail extends StatefulWidget {
  final String videoUrl;
  final Duration position;

  const VideoThumbnail({
    super.key,
    required this.videoUrl,
    this.position = const Duration(seconds: 0),
  });

  @override
  State<StatefulWidget> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late Player _player;
  Uint8List? _thumbnailBytes;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _player = Player();
    await _player.open(Media(widget.videoUrl));
    await _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    try {
      // 设置播放器位置
      await _player.seek(widget.position);

      // 等待一小段时间确保帧已经准备好
      await Future.delayed(const Duration(milliseconds: 100));

      // 生成缩略图
      final bytes = await _player.screenshot(format: 'image/png');

      setState(() {
        _thumbnailBytes = bytes;
      });
    } catch (e) {
      print('Error generating thumbnail: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_thumbnailBytes == null) {
      return const CircularProgressIndicator();
    }

    return Image.memory(_thumbnailBytes!);
  }
}
