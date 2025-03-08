import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_architecture_template/core/network/api_client.dart';
import 'package:clean_architecture_template/core/network/network_info.dart';

final sl = GetIt.instance;

/// Initializes service locator with core dependencies
Future<void> initCoreServices() async {
  // Core
  sl.registerLazySingleton<Logger>(() => Logger());
  
  // Network
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: sl()));
  
  // API Client
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com', // Replace with your API base URL
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors if needed
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (log) => sl<Logger>().d(log),
    ));
    
    return dio;
  });
  
  sl.registerLazySingleton<ApiClient>(() => ApiClient(
    dio: sl(),
    logger: sl(),
    networkInfo: sl(),
  ));
  
  // Local Storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

/// Initializes feature-specific dependencies
Future<void> initFeatureServices() async {
  // Register feature-specific repositories, services, and use cases here
  
  // Example:
  // User Feature
  // sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
  //   apiClient: sl(),
  //   localDataSource: sl(),
  // ));
  // sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(repository: sl()));
}

/// Initializes all dependencies
Future<void> init() async {
  await initCoreServices();
  await initFeatureServices();
} 