import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/pages/panel_screen.dart';
import 'package:gabarite_board_cfc/src/shared/di/dependency_injector.dart';
import 'package:gabarite_board_cfc/src/shared/extension/extension_context.dart';
import 'package:gabarite_board_cfc/src/theme/app_theme.dart';

import '/src/modules/panel/view/bloc/panel_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    context.uiConfigurations;
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => dependencyInjector<PanelBloc>()..load())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.ligth,
        home: const PanelScreen(),
      ),
    );
  }
}
