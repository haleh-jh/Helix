import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_string_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_user_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/set_string_usecase.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  final GetStringUseCase _getStringUseCase;
  final SetStringUseCase _setStringUseCase;
  final GetUserUseCase _getUserUseCase;

  AppCubit(
      {required GetStringUseCase getStringUseCase,
      required SetStringUseCase setStringUseCase,
      required GetUserUseCase getUserUseCase})
      : _getStringUseCase = getStringUseCase,
        _setStringUseCase = setStringUseCase,
        _getUserUseCase = getUserUseCase,
        super(const AppState.init(isLogged: false)) {
    _checkLogginUser();
  }

  Future<void> _checkLogginUser() async {
    final token = await _getStringUseCase(
        params: const SharedPrefStringRequestParams(key: 'token'));
    print("token: $token");
    if (token is DataFailure || token.data!.isEmpty) {
      emit(const AppState.success(isLogged: false));
    } else {
      _getUserInfo(token.data!);
    }
  }

  Future<void> _getUserInfo(String token) async {
    final dataState =
        await _getUserUseCase(params: UserRequestParams(token: token));

    if (dataState is DataFailure) {
      emit(const AppState.error());
      return;
    }
    emit(const AppState.success(isLogged: true));
  }
}
