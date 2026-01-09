import 'package:supabase_flutter/supabase_flutter.dart';

import '../export/app_export.dart';

final dependencyInjector = GetIt.instance;

Future<void> setupDependencyInjector() async {
  final client = await SupabaseInitializer.create();
  final sharedPreferences = await SharedPreferences.getInstance();
  final connectivity = Connectivity();

  dependencyInjector
    
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: connectivity))
    ..registerLazySingleton<NetworkVerifier>(() => NetworkVerifier(networkInfo: dependencyInjector()))
    ..registerLazySingleton<StorageService>(() => StorageServiceImpl(instance: sharedPreferences))
    ..registerLazySingleton<SupabaseClient>(() => client)
    ..registerSingleton<RealtimeManager>(SupabaseRealtimeImpl(client: client))
    ..registerSingleton<FunctionDatabase>(SupabaseRpcImpl(client: client))
    ..registerSingleton<AuthManager>(AuthSupabaseImpl(client: client))
    ..registerSingleton<DataManager>(ManagerSupabaseImpl(client: client))
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  _setupModuleSplash();
  _setupModuleMenu();
  _setupModuleAuth();
  _setupModulePermission();
  _setupModuleBoard();
  _setupModuleNote();
  _setupModuleLink();
  _setupModuleCompetitors();
  _setupModuleVisibility();
  _setupModuleSettings();
}

void _setupModuleAuth() {
  dependencyInjector
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
          service: dependencyInjector(), storageService: dependencyInjector(), permissionService: dependencyInjector()),
    )
    ..registerFactory<AuthFormBloc>(
      () => AuthFormBloc(),
    )
    ..registerLazySingleton<AuthService>(
      () => AuthServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        networkVerifier: dependencyInjector(),
        authManager: dependencyInjector(),
      ),
    );
}

void _setupModulePermission() {
  dependencyInjector
    ..registerLazySingleton<PermissionService>(
      () => PermissionServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<PermissionRepository>(
      () => PermissionRepositoryImpl(
        networkVerifier: dependencyInjector(),
        dataManager: dependencyInjector(),
      ),
    );
}

void _setupModuleBoard() {
  dependencyInjector
    ..registerFactory<BoardBloc>(
      () => BoardBloc(
        service: dependencyInjector(),
        noteService: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<BoardService>(
      () => BoardServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<BoardRepository>(
      () => BoardRepositoryImpl(
        networkVerifier: dependencyInjector(),
        dataManager: dependencyInjector(),
      ),
    );
}

void _setupModuleNote() {
  dependencyInjector
    ..registerFactory<NoteBloc>(() => NoteBloc(service: dependencyInjector()))
    ..registerLazySingleton<NoteService>(() => NoteServiceImpl(repository: dependencyInjector()))
    ..registerLazySingleton<NoteRepository>(
        () => NoteRepositoryImpl(networkVerifier: dependencyInjector(), dataManager: dependencyInjector()));
}

void _setupModuleLink() {
  dependencyInjector
    ..registerFactory<LinkBloc>(
      () => LinkBloc(
        boardService: dependencyInjector(),
        linkService: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<LinkService>(
      () => LinkServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<LinkRepository>(
      () => LinkRepositoryImpl(
        networkVerifier: dependencyInjector(),
        dataManager: dependencyInjector(),
      ),
    );
}

void _setupModuleCompetitors() {
  dependencyInjector
    ..registerFactory<CompetitorBloc>(
      () => CompetitorBloc(
        service: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<CompetitorService>(
      () => CompetitorsServiceImpl(
        remoteDataSource: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<CompetitorRepository>(
      () => CompetitorRepositoryImpl(
        dataManager: dependencyInjector(),
        networkVerifier: dependencyInjector(),
        realtimeManager: dependencyInjector(),
      ),
    );
}

void _setupModuleVisibility() {
  dependencyInjector
    ..registerFactory<VisibilityBloc>(
      () => VisibilityBloc(
        service: dependencyInjector(),
        boardService: dependencyInjector(),
        noteService: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<VisibilityService>(
      () => VisibilityServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<VisibilityRepository>(
      () => VisibilityRepositoryImpl(
        networkVerifier: dependencyInjector(),
        dataManager: dependencyInjector(),
        functionDatabase: dependencyInjector(),
      ),
    );
}

void _setupModuleSettings() {
  dependencyInjector
    ..registerFactory<SettingBloc>(
      () => SettingBloc(
        service: dependencyInjector(),
        noteService: dependencyInjector(),
        permissionService: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<SettingService>(
      () => SettingServiceImpl(
        repository: dependencyInjector(),
      ),
    )
    ..registerLazySingleton<SettingRepository>(
      () => SettingRepositoryImpl(
        networkVerifier: dependencyInjector(),
        dataManager: dependencyInjector(),
        functionDatabase: dependencyInjector(),
      ),
    );
}

void _setupModuleSplash() {
  dependencyInjector.registerFactory<SplashBloc>(
    () => SplashBloc(
      service: dependencyInjector(),
    ),
  );
}

void _setupModuleMenu() {
  dependencyInjector.registerFactory<MenuBloc>(
    () => MenuBloc(
      service: dependencyInjector(),
      permissionService: dependencyInjector(),
    ),
  );
}
