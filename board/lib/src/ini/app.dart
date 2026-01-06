import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    context.uiConfigurations;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => dependencyInjector<PanelBloc>()..load()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.ligth,
        home: const PanelScreen(),
      ),
    );
  }
}
