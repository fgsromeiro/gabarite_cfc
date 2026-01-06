import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:gabarite_board_cfc/src/shared/interface/export_image.dart';
import 'package:web/web.dart' as web;

class ExportImageImpl implements ExportImage {
  @override
  Future<void> captureAndDownload(ui.Image image, String name) async {
    try {
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception('Falha ao converter imagem');

      final pngBytes = byteData.buffer.asUint8List();
      final base64Data = base64Encode(pngBytes);
      final url = 'data:image/png;base64,$base64Data';

      final anchor = web.HTMLAnchorElement()
        ..href = url
        ..download = '$name.png'
        ..style.display = 'none';

      web.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      web.URL.revokeObjectURL(url);
    } catch (e) {
      log('Erro ao capturar imagem: $e');
      rethrow;
    }
  }
}
