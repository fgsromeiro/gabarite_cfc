import 'dart:developer';

import 'package:gabarite_cfc/src/shared/responsive/config_responsive/competitor_config.dart';

import '../export/app_export.dart';

class UiConfigurations {
  final BuildContext context;
  late AuthConfig authConfig;
  late CompetitorConfig competitorConfig;

  UiConfigurations(this.context) {
    if (context.isSmall) {
      log('DISPLAY WIDTH -> SMALL');
      _small();
    } else if (context.isMedium) {
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
    AppSpacing.scale = 1.0;
    AppIconSizes.scale = 1.3;
    authConfig = AuthConfig();
    competitorConfig = CompetitorConfig(
      // columnWidthQuestion: FixedColumnWidth(
      //   context.sz.width * 0.140,
      // ),
      columnWidth: FixedColumnWidth(
        context.sz.width * 0.140,
      ),
      fatorScaleField: 0.08,
    );
  }

  void _xxLarge() {
    AppInsets.scale = 1.5;
    AppFontSize.scale = 0.9;
    AppSpacing.scale = 1.5;
    authConfig = AuthConfig();
    competitorConfig = CompetitorConfig(
      columnWidth: FixedColumnWidth(context.sz.width * 0.135),
      fatorScaleField: 0.08,
    );
  }

  void _xLarge() {
    authConfig = AuthConfig(isVisibilityBanner: false, direction: Axis.horizontal);
    AppFontSize.scale = 0.86;
    AppBannerSize.scale = 1.5;
    AppSpacing.scale = 1.5;
    competitorConfig = CompetitorConfig(
      columnWidth: FixedColumnWidth(context.sz.width * 0.140),
      fatorScaleField: 0.08,
    );
  }

  void _large() {
    authConfig = AuthConfig(isVisibilityBanner: false, direction: Axis.vertical, percential: 0.8);
    AppFontSize.scale = 0.85;
    AppBannerSize.scale = 0.5;
    AppSpacing.scale = 1.5;
    AppInsets.scale = 2.0;
    AppIconSizes.scale = 1.0;
    competitorConfig = CompetitorConfig(
      columnWidth: FixedColumnWidth(context.sz.width * 0.18),
      fatorScaleField: 0.08,
    );
  }

  void _medium() {
    authConfig = AuthConfig(
      isVisibilityBanner: false,
      direction: Axis.vertical,
      percential: 0.8,
    );
    AppFontSize.scale = 1.0;
    AppBannerSize.scale = 1.5;
    AppSpacing.scale = 2.0;
    AppInsets.scale = 2.0;
    competitorConfig = CompetitorConfig(
      columnWidth: FixedColumnWidth(context.sz.width * 0.250),
      fatorScaleField: 0.15,
    );
  }

  void _small() {
    authConfig = AuthConfig(
      isVisibilityBanner: false,
      direction: Axis.vertical,
      percential: 1,
    );
    AppFontSize.scale = 0.85;
    AppBannerSize.scale = 1.5;
    AppSpacing.scale = 1.7;
    AppInsets.scale = 1.2;
    AppInsets.scale = 1.2;
    competitorConfig = CompetitorConfig(
      columnWidth: FixedColumnWidth(context.sz.width * 0.50),
      fatorScaleField: 0.20,
    );
  }
}
