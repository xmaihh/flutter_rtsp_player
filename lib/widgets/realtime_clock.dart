import 'dart:async';

import 'package:flutter/material.dart';

class RealTimeClock extends StatefulWidget {
  final bool isUpdating;

  RealTimeClock({required this.isUpdating});

  @override
  State<RealTimeClock> createState() => _RealTimeClockState();
}

class _RealTimeClockState extends State<RealTimeClock> {
  late bool isUpdating;

  @override
  void initState() {
    super.initState();
    isUpdating = widget.isUpdating;
  }

  @override
  void didUpdateWidget(RealTimeClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isUpdating != widget.isUpdating) {
      setState(() {
        isUpdating = widget.isUpdating;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now()).where((_) => isUpdating),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final now = snapshot.data ?? DateTime.now();
          final timeString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
          return Text(
            timeString,
            style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          );
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 10.0,
        );
      },
    );
  }
}
