import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:helix_with_clean_architecture/src/app/cubit/app_cubit.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/http_client.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/local/shared_pref_service/abstracts/shared_pref_service.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/local/shared_pref_service/concretes/shared_pref_service_impl.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/abstracts/user_api_service.dart';
import 'package:helix_with_clean_architecture/src/data/datasources/remote/user_service/concretes/user_api_service_impl.dart';
import 'package:helix_with_clean_architecture/src/data/repositories/service_repository_impl.dart';
import 'package:helix_with_clean_architecture/src/data/repositories/shared_pref_repository_impl.dart';
import 'package:helix_with_clean_architecture/src/data/repositories/user_repository_impl.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/service_repository.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/shared_pref_repository.dart';
import 'package:helix_with_clean_architecture/src/domain/repositories/user_repository.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_drop_down_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_string_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_user_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/set_string_usecase.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/cubit/main_screen_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/remote/user_service/abstracts/api_service.dart';
import 'data/datasources/remote/user_service/concretes/api_service_impl.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  injector
    ..registerSingleton<SharedPreferences>(sharedPreferences)
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<TextEditingController>(TextEditingController(text: ''))
    ..registerSingleton<SharedPrefService>(
        SharedPrefServiceImpl(preferences: injector()))
    ..registerSingleton<SharedPrefRepository>(
        SharedPrefRepositoryImpl(sharedPrefService: injector()))
    ..registerSingleton<GetStringUseCase>(
        GetStringUseCase(sharedPrefRepository: injector()))
    ..registerSingleton<SetStringUseCase>(
      SetStringUseCase(sharedPrefRepository: injector()),
    )
    ..registerSingleton<UserApiService>(UserApiServiceImpl(dio: httpClient))
    ..registerSingleton<UserRepository>(
        UserRepositoryImpl(userApiService: injector()))
    ..registerSingleton<ApiService>(ApiServiceImpl(dio: httpClient))
    ..registerSingleton<ServiceRepository>(
        ServiceRepositoryImpl(apiService: injector()))
    ..registerSingleton<GetUserUseCase>(
        GetUserUseCase(userRepository: injector()))
    ..registerSingleton<GetAllUseCase>(
        GetAllUseCase(serviceRepository: injector()))
    ..registerFactory<AppCubit>(
      () => AppCubit(
          getStringUseCase: injector(),
          setStringUseCase: injector(),
          getUserUseCase: injector()),
    )
    ..registerFactory<MainScreenCubit>(() => MainScreenCubit())
    ..registerFactory<DashboardBloc>(() => DashboardBloc(getStringUseCase: injector(), getAllUseCase: injector()));
}
