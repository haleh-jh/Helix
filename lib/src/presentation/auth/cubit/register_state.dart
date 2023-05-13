part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = _Initial;
  const factory RegisterState.registerLoading() = _RegisterLoading;
  const factory RegisterState.registerSuccess() = _RegisterSuccess;
  const factory RegisterState.registerError() = _RegisterError;
}
