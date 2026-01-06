import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Size get sz => MediaQuery.of(this).size;
  double get width => sz.width;

  bool get isSmall => width <= AppBreakpoints.sm;
  bool get isMobile => !isSmall && width <= AppBreakpoints.md;
  bool get isLarge => !isMobile && width <= AppBreakpoints.lg;
  bool get isXLarge => !isLarge && width <= AppBreakpoints.xl;
  bool get isXXLarge => !isXLarge && width <= AppBreakpoints.xxl;
  bool get isXXXLarge => !isXXLarge && width <= AppBreakpoints.xxxl;
  bool get fromMed => isMobile || isLarge || isXLarge;
  bool get fromLg => isLarge || isXLarge || isXXLarge;
  bool get fromXLg => isXLarge || isXXLarge;
  UiConfigurations get uiConfigurations => UiConfigurations(this);
  ResponsiveGridView get gridView => UiConfigurations(this).gridView;
  ResponsivePanel get panel => UiConfigurations(this).responsivePanel;
}

extension Spacers on int {
  SizedBox get h => SizedBox(height: (this as num).toDouble(), width: 0);
  SizedBox get w => SizedBox(width: (this as num).toDouble(), height: 0);
}
