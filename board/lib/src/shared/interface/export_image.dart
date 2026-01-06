import 'dart:ui' as ui;

abstract class ExportImage {
  Future<void> captureAndDownload(ui.Image image, String name);
}
