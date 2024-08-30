import 'dart:async';

import 'package:flutter/material.dart';

class RealTimeClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final now = snapshot.data ?? DateTime.now();
          final timeString = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
          return Text(
            timeString,
            style: TextStyle(color: Colors.white, fontSize: 16),
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
