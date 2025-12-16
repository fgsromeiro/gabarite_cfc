import 'dart:developer';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;

abstract class ExportImage {
  Future<void> captureAndDownload(ui.Image image, String name);
}

class ExportImageImpl implements ExportImage {
  @override
  Future<void> captureAndDownload(ui.Image image, String name) async {
    try {
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final blob = html.Blob([pngBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "$name.png")
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      log("Erro ao capturar: $e");
      rethrow;
    }
  }
}
