import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  final double volume;
  final double size;
  final double minVolume;
  final double maxVolume;
  final void Function(double) onVolumeChanged;

  const VolumeSlider({super.key, this.volume = 0.5, this.size = 120, this.minVolume = 0, this.maxVolume = 1.25, required this.onVolumeChanged});

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _volume = 0; // 初始音量

  @override
  void initState() {
    super.initState();
    _volume = widget.volume;
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.size; // Container的宽度
    double triangleHeight = width / 3.6; // 高度与宽度的比例

    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(
            child: CustomPaint(
              painter: RoundedTriangleSliderPainter(widget.volume, widget.maxVolume),
              child: SizedBox(
                height: triangleHeight, // 比例高度
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: triangleHeight,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                  ),
                  child: Slider(
                    value: widget.volume,
                    onChanged: (newVolume) {
                      widget.onVolumeChanged(newVolume);
                    },
                    min: widget.minVolume,
                    max: widget.maxVolume, // 允许音量超过100%
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedTriangleSliderPainter extends CustomPainter {
  final double volume;
  final double maxVolume;

  RoundedTriangleSliderPainter(this.volume, this.maxVolume);

  @override
  void paint(Canvas canvas, Size size) {
    Paint trackPaint = Paint()
      ..color = Colors.white.withAlpha(245)
      ..style = PaintingStyle.fill;

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.green, Colors.yellow, Colors.red],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width * (volume / maxVolume), size.height))
      ..style = PaintingStyle.fill;

    // 绘制背景三角形
    Path trackPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    // 绘制进度三角形
    Path progressPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * (volume / maxVolume), size.height - (size.height * (volume / maxVolume)))
      ..lineTo(size.width * (volume / maxVolume), size.height)
      ..close();

    canvas.drawPath(trackPath, trackPaint);
    canvas.drawPath(progressPath, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
