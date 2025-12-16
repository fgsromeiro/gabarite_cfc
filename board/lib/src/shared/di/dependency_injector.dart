import 'package:gabarite_board_cfc/src/modules/panel/data/panel_remote_data_source.dart';
import 'package:gabarite_board_cfc/src/modules/panel/models/export_image.dart';
import 'package:gabarite_board_cfc/src/modules/panel/service/panel_service.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/bloc/panel_bloc.dart';
import 'package:gabarite_board_cfc/src/shared/database/supabase_initializer.dart';
import 'package:gabarite_board_cfc/src/shared/database/supabase_repository.dart';
import 'package:gabarite_board_cfc/src/shared/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final dependencyInjector = GetIt.instance;

Future<void> setupDependencyInjector() async {
  final client = await SupabaseInitializer.create();

  dependencyInjector
    ..registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new)
    ..registerLazySingleton<SupabaseClient>(() => client)
    ..registerSingleton<SupabaseRepository>(SupabaseRepositoryImpl(client: client))
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
    ..registerLazySingleton<PanelRemoteDataSource>(
      () => PanelRemoteDataSourceImpl(
        networkInfo: dependencyInjector(),
        supabase: dependencyInjector(),
      ),
    );
}
