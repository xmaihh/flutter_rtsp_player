import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

String saveImageImpl(Uint8List imageBytes, String fileName) {
  try {
    final base64Data = base64Encode(imageBytes);
    final dataUrl = 'data:image/png;base64,$base64Data';

    final anchor = html.AnchorElement(href: dataUrl)
      ..setAttribute('download', fileName)
      ..click();
    return 'Saved. $fileName';
  } catch (e) {
    return 'Failed. $e';
  }
}
