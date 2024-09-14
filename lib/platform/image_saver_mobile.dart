import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageSaverMobile {
  static Future<String> save(Uint8List imageBytes, String fileName) async {
    if (await _requestPermission()) {
      try {
        final result = await ImageGallerySaver.saveImage(imageBytes, name: fileName, isReturnImagePathOfIOS: true);
        return '$result';
      } catch (e) {
        return 'Failed. $e';
      }
    } else {
      return 'Permission denied.';
    }
  }

  static Future<bool> _requestPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }
    return status.isGranted;
  }
}
