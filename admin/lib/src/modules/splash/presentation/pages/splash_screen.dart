import '../../../../shared/export/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashBloc bloc;

  @override
  void initState() {
    bloc = context.read<SplashBloc>();
    bloc.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status.isAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutesSchema.homeScreen);
        }

        if (state.status.isUnauthenticated) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutesSchema.loginScreen,
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: AppLoadingIndicator(),
      ),
    );
  }
}
