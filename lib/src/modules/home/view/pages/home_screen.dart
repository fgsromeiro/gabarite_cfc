import 'package:gabarite_cfc/src/modules/board/view/pages/panel_board_sm_screen.dart';

import '../../../../shared/export/app_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.user,
  });

  final UserModel? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<MenuBloc>().init(widget.user);
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return PanelBoardSmScreen();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Navigator.popAndPushNamed(context, AppRoutesSchema.loginScreen);
      },
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          _tabController.animateTo(state.currentIndex);

          return Scaffold(
            backgroundColor: context.colorScheme.surface,
            body: Padding(
              padding: EdgeInsets.all(AppInsets.med),
              child: Flex(
                direction: Axis.horizontal,
                spacing: AppSpacing.lg,
                children: [
                  Flexible(
                    flex: AppFlex.sm,
                    child: Menu(),
                  ),
                  Flexible(
                    flex: AppFlex.xl,
                    child: Column(
                      spacing: AppSpacing.sm,
                      children: [
                        AppBarContainer(),
                        AppContent(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              PanelBoard(),
                              PanelLinkScreen(),
                              CompetitorBoard(),
                              VisibilityBoard(),
                              SettingsPanel(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
