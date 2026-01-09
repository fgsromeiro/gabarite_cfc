import '../shared/export/app_export.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    context.uiConfigurations;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => dependencyInjector<SplashBloc>()),
        BlocProvider(create: (context) => dependencyInjector<AuthBloc>()),
        BlocProvider(create: (context) => dependencyInjector<AuthFormBloc>()),
        BlocProvider(create: (context) => dependencyInjector<MenuBloc>()),
        BlocProvider(create: (context) => dependencyInjector<BoardBloc>()),
        BlocProvider(create: (context) => dependencyInjector<LinkBloc>()),
        BlocProvider(create: (context) => dependencyInjector<CompetitorBloc>()..listenToChanges()),
        BlocProvider(create: (context) => dependencyInjector<NoteBloc>()..fetchNotes()),
        BlocProvider(create: (context) => dependencyInjector<VisibilityBloc>()),
        BlocProvider(create: (context) => dependencyInjector<SettingBloc>()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        supportedLocales: const [Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
        theme: AppTheme.ligth,
        onGenerateRoute: AppRoute.routes,
      ),
    );
  }
}
