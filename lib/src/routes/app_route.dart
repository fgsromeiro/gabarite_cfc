import 'package:gabarite_cfc/src/modules/board/view/pages/panel_board_sm_form_screen.dart';
import 'package:gabarite_cfc/src/modules/board/view/pages/panel_board_sm_screen.dart';
import 'package:gabarite_cfc/src/modules/competitor/view/pages/competitor_board_sm_screen.dart';
import 'package:gabarite_cfc/src/modules/link/view/pages/panel_link_sm_screen.dart';
import 'package:gabarite_cfc/src/modules/setting/view/pages/settings_panel_sm_screen.dart';
import 'package:gabarite_cfc/src/modules/visibility/view/pages/visibility_board_sm_screen.dart';

import '../shared/export/app_export.dart';

class AppRoute {
  static MaterialPageRoute onNavegation(Widget screen, RouteSettings settings) => MaterialPageRoute(
        builder: (context) => screen,
        settings: settings,
      );

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesSchema.initial:
        // return onNavegation(PanelBoardSm(), settings);
        // return onNavegation(
        //     PanelBoardFormSmScreen(
        //       question: QuestionReference.instance(),
        //     ),
        //     settings);
        return onNavegation(SplashScreen(), settings);
      // return onNavegation(CompetitorBoard(), settings);
      // return onNavegation(PanelLinkSmScreen(), settings);
      case AppRoutesSchema.loginScreen:
        return onNavegation(AuthScreen(), settings);
      case AppRoutesSchema.homeScreen:
        return onNavegation(HomeScreen(), settings);
      case AppRoutesSchema.boardSmScreen:
        return onNavegation(PanelBoardSmScreen(), settings);
      case AppRoutesSchema.boardFormSmScreen:
        final question = settings.arguments as TBL0003;
        return onNavegation(PanelBoardFormSmScreen(question: question), settings);
      case AppRoutesSchema.panelLinkSmScreen:
        return onNavegation(PanelLinkSmScreen(), settings);
      case AppRoutesSchema.competitorScreen:
        return onNavegation(CompetitorBoard(), settings);
      case AppRoutesSchema.competitorSmScreen:
        return onNavegation(CompetitorBoardSmScreen(), settings);
      case AppRoutesSchema.visibilitySmScreen:
        return onNavegation(VisibilityBoardSmScreen(), settings);
      case AppRoutesSchema.settingPanelSmScreen:
        return onNavegation(SettingsPanelSmScreen(), settings);
      default:
        return onNavegation(
          Scaffold(
            body: AppError(message: 'Rota não encontrada'),
          ),
          settings,
        );
    }
  }
}
