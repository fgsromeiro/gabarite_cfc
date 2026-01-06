import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

final dependencyInjector = GetIt.instance;

Future<void> setupDependencyInjector() async {
  final client = await SupabaseInitializer.create();

  dependencyInjector
    ..registerLazySingleton<SupabaseClient>(() => client)
    ..registerLazySingleton<DataManager>(() => SupabaseManagerImpl(client: client))
    ..registerLazySingleton<RealtimeManager>(() => SupabaseRealtimeImpl(client: client))
    ..registerLazySingleton<ExportImage>(ExportImageImpl.new);

  _setupModulePanel();
}

void _setupModulePanel() {
  dependencyInjector
    ..registerFactory<PanelBloc>(
      () => PanelBloc(
        service: dependencyInjector(),
        serviceExport: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<PanelService>(
      () => PanelServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<PanelRepository>(
      () => PanelRepositoryImpl(
        dataManager: dependencyInjector(),
        realtimeManager: dependencyInjector(),
      ),
    );
}
