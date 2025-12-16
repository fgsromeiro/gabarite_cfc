import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/shared/responsive/app_breakpoints.dart';
import 'package:gabarite_board_cfc/src/shared/responsive/responsive_grid_view.dart';
import 'package:gabarite_board_cfc/src/shared/responsive/responsive_panel.dart';
import 'package:gabarite_board_cfc/src/shared/responsive/ui_configurations.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Size get sz => MediaQuery.of(this).size;
  double get width => sz.width;
  bool get isMobile => width <= AppBreakpoints.md;

  bool get isSmall => width <= AppBreakpoints.sm;
  bool get isMedium => !isSmall && width <= AppBreakpoints.md;
  bool get isLarge => !isMedium && width <= AppBreakpoints.lg;
  bool get isXLarge => !isLarge && width <= AppBreakpoints.xl;
  bool get isXXLarge => !isXLarge && width <= AppBreakpoints.xxl;
  bool get isXXXLarge => !isXXLarge && width <= AppBreakpoints.xxxl;
  bool get fromMed => isMedium || isLarge || isXLarge;
  bool get fromLg => isLarge || isXLarge || isXXLarge;
  bool get fromXLg => isXLarge || isXXLarge;
  UiConfigurations get uiConfigurations => UiConfigurations(this);
  ResponsiveGridView get gridView => UiConfigurations(this).gridView;
  ResponsivePanel get panel => UiConfigurations(this).responsivePanel;
}

extension Spacers on int {
  SizedBox get h => SizedBox(height: toDouble(), width: 0);
  SizedBox get w => SizedBox(width: toDouble(), height: 0);
}
