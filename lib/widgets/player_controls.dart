import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rtsp_player/common/video_player_controller.dart';
import 'package:flutter_rtsp_player/utils/image_saver.dart';
import 'package:flutter_rtsp_player/widgets/volume_slider.dart';
import 'package:media_kit/media_kit.dart';

class PlayerControls extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final double volumeSliderSize;

  PlayerControls({required this.videoPlayerController, this.volumeSliderSize = 100.0});

  @override
  State<StatefulWidget> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  late final Player _player;
  double _currentVolume = 0.0;
  bool _playing = true;

  @override
  void initState() {
    super.initState();
    _player = widget.videoPlayerController.player;
    _currentVolume = _player.state.volume;
    _player.stream.volume.listen((volume) {
      if (mounted) {
        setState(() {
          _currentVolume = volume;
        });
      }
    });
    _player.stream.playing.listen((playing) {
      if (mounted) {
        setState(() {
          _playing = playing;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            _playing ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            // Implement play functionality
            widget.videoPlayerController.playOrPause();
          },
        ),
        IconButton(
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: takeSnapshort,
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.fiber_manual_record,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        // ),
        IconButton(
          icon: Icon(
            _currentVolume == 0 ? Icons.volume_off : (_currentVolume > 0.50 ? Icons.volume_up : Icons.volume_down),
            color: Colors.white,
          ),
          onPressed: () {
            _player.setVolume(_currentVolume == 0 ? 65 : 0);
          },
        ),
        // VolumeControlWidget(),
        Column(
          children: [
            VolumeSlider(
              volume: (_currentVolume > 0) ? (_currentVolume / 100) : 0,
              maxVolume: 1,
              size: widget.volumeSliderSize,
              onVolumeChanged: (newVolume) {
                _player.setVolume(newVolume * 100);
              },
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          '${(_currentVolume).round()}%',
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> takeSnapshort() async {
    final imageBytes = await widget.videoPlayerController.player.screenshot();
    final fileName = ImageSaver.generateFileName();
    print(fileName);
    String result = await ImageSaver.saveImage(imageBytes!, fileName);
    BotToast.showText(text: result);
  }
}
