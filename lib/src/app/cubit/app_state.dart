part of 'app_cubit.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState.init({required bool isLogged}) = _Init;
  const factory AppState.success({required bool isLogged}) = _Success;
  const factory AppState.error() = _Error;
}
