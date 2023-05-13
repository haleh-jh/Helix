import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_set_string_params.dart';

import '../../../domain/usecases/get_string_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../domain/usecases/set_string_usecase.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GetStringUseCase _getStringUseCase;
  final SetStringUseCase _setStringUseCase;
  final RegisterUseCase _registerUseCase;
  RegisterCubit({
    required GetStringUseCase getStringUseCase,
    required SetStringUseCase setStringUseCase,
    required RegisterUseCase registerUseCase,
  })  : _getStringUseCase = getStringUseCase,
        _setStringUseCase = setStringUseCase,
        _registerUseCase = registerUseCase,
        super(RegisterState.initial());

  void register(String userInfo) async {
    emit(const RegisterState.registerLoading());
    try {
      Future.delayed(Duration(milliseconds: 2000)).then(
        (value) async {
          final dataState =
              await _registerUseCase(params: userInfo).then((v) async {
            await _setStringUseCase(
                params:
                    SharedPrefSetStringParams(key: 'token', value: v.data!));
          });
        },
      );

      emit(const RegisterState.registerSuccess());
    } catch (e) {
      emit(const RegisterState.registerError());
      if (e is DioErrorType) {
        print("${e.name}");
      }
    }
  }
}
