import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class ImageSaverDesktop {
  static Future<String> save(Uint8List imageBytes, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/$fileName';

      final file = File(path);
      await file.writeAsBytes(imageBytes);
      return 'Saved. $path';
    } catch (e) {
      return 'Failed. $e';
    }
  }
}
