import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class CompetitorConfig {
  final TableColumnWidth? columnWidth;
  final double fatorScaleField;

  CompetitorConfig({
    required this.fatorScaleField,
    this.columnWidth,
  });
}
