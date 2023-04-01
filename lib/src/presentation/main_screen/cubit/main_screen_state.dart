part of 'main_screen_cubit.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState.initial() = _Initial;
  const factory MainScreenState.changeScreenState(int selectedScreen) = _ChangeScreenState;
}
