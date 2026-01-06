import 'dart:developer';

import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class UiConfigurations {
  final BuildContext context;
  late ResponsiveGridView gridView;
  late ResponsivePanel responsivePanel;

  UiConfigurations(this.context) {
    if (context.isSmall) {
      log('DISPLAY WIDTH -> SMALL');
      _small();
    } else if (context.isMobile) {
      log('DISPLAY WIDTH -> MEDIUM');
      _medium();
    } else if (context.isLarge) {
      log('DISPLAY WIDTH -> LARGE');
      _large();
    } else if (context.isXLarge) {
      log('DISPLAY WIDTH -> XLARGE');
      _xLarge();
    } else if (context.isXXLarge) {
      log('DISPLAY WIDTH -> XXLARGE');
      _xxLarge();
    } else {
      log('DISPLAY WIDTH -> XXXLARGE');
      _xxxLarge();
    }
  }

  void _xxxLarge() {
    AppFontSize.scale = 1.0;
    AppInsets.scale = 1.5;
    responsivePanel = ResponsivePanel(factorWidth: 0.56);
    gridView = ResponsiveGridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisExtent: 88,
        crossAxisSpacing: 4,
      ),
      padding: EdgeInsetsGeometry.all(15),
    );
  }

  void _xxLarge() {
    AppInsets.scale = 1.5;
    AppFontSize.scale = 0.8;
    AppSpacing.scale = 1.5;
    responsivePanel = ResponsivePanel(factorWidth: 0.58);
    gridView = ResponsiveGridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisExtent: 67,
        crossAxisSpacing: 2,
      ),
      padding: EdgeInsetsGeometry.all(15),
    );
  }

  void _xLarge() {
    AppInsets.scale = 1.4;
    AppFontSize.scale = 0.7;
    AppSpacing.scale = 1.5;
    responsivePanel = ResponsivePanel(factorWidth: 0.60);
    gridView = ResponsiveGridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisExtent: 61,
        crossAxisSpacing: 2,
      ),
      padding: EdgeInsetsGeometry.all(13),
    );
  }

  void _large() {
    AppInsets.scale = 1.4;
    AppFontSize.scale = 0.7;
    AppSpacing.scale = 1.5;
    responsivePanel = ResponsivePanel(factorWidth: 0.60);
    gridView = ResponsiveGridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        mainAxisExtent: 61,
        crossAxisSpacing: 2,
      ),
      padding: EdgeInsetsGeometry.all(13),
    );
  }

  void _medium() {
    AppFontSize.scale = 0.5;
  }

  void _small() {}
}
