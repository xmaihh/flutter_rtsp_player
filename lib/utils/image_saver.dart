import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_rtsp_player/platform/image_saver_desktop.dart';
import 'package:flutter_rtsp_player/platform/image_saver_mobile.dart';
import 'package:flutter_rtsp_player/platform/image_saver_stub.dart' if (dart.library.html) 'package:flutter_rtsp_player/platform/image_saver_web.dart';

class ImageSaver {
  static String generateFileName({String prefix = 'flsnap', String extension = 'jpg'}) {
    final DateTime now = DateTime.now();
    final formattedTime = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}-${now.hour.toString().padLeft(2, '0')}h${now.minute.toString().padLeft(2, '0')}m${now.second.toString().padLeft(2, '0')}s${now.millisecond.toString().padLeft(3, '0')}";
    return '$prefix-$formattedTime.$extension';
  }

  static Future<String> saveImage(Uint8List imageBytes, String fileName) async {
    if (kIsWeb) {
      return _saveImageWeb(imageBytes, fileName);
    } else if (io.Platform.isWindows || io.Platform.isMacOS || io.Platform.isLinux) {
      return await _saveImageDesktop(imageBytes, fileName);
    } else if (io.Platform.isAndroid || io.Platform.isIOS) {
      return await _saveImageMobile(imageBytes, fileName);
    } else {
      return 'not support yet';
    }
  }

  static String _saveImageWeb(Uint8List imageBytes, String fileName) {
    return saveImageImpl(imageBytes, fileName);
  }

  static Future<String> _saveImageDesktop(Uint8List imageBytes, String fileName) async {
    return await ImageSaverDesktop.save(imageBytes, fileName);
  }

  static Future<String> _saveImageMobile(Uint8List imageBytes, String fileName) async {
    return await ImageSaverMobile.save(imageBytes, fileName);
  }
}
