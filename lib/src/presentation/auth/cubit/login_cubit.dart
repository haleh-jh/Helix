import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_success.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_string_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/login_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/set_string_usecase.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final GetStringUseCase _getStringUseCase;
  final SetStringUseCase _setStringUseCase;
  final LoginUseCase _loginUseCase;
  LoginCubit({
    required GetStringUseCase getStringUseCase,
    required SetStringUseCase setStringUseCase,
    required LoginUseCase loginUseCase,
  })  : _getStringUseCase = getStringUseCase,
        _setStringUseCase = setStringUseCase,
        _loginUseCase = loginUseCase,
        super(LoginState.initial());

  Future<void> login(String userInfo, BuildContext context) async {
      emit(const LoginState.loginLoading());
      final dataState = await _loginUseCase(params: userInfo);
      if (dataState is DataSuccess) {
        await _setStringUseCase(
            params: SharedPrefSetStringParams(
                key: 'token', value: dataState.data!));
        emit(const LoginState.loginSuccess());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainScreen()));
      } else if (dataState is DataFailure) {
        print("e1: ${dataState.data}");
        print("e2: ${dataState.errorMessage}");
        print("e3: ${dataState.errorTitle}");
              emit(const LoginState.loginError());
      }
    
  }
}
