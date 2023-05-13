part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loginLoading() = _LoginLoading;
  const factory LoginState.loginSuccess() = _LoginSuccess;
  const factory LoginState.loginError() = _LoginError;
}
