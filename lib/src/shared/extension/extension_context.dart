import 'package:gabarite_cfc/src/shared/responsive/config_responsive/competitor_config.dart';

import '../export/app_export.dart';

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
  AuthConfig get authConfig => uiConfigurations.authConfig;
  CompetitorConfig get competitorConfig => uiConfigurations.competitorConfig;
}

extension Spacers on int {
  SizedBox get h => SizedBox(height: toDouble(), width: 0);
  SizedBox get w => SizedBox(width: toDouble(), height: 0);
}
