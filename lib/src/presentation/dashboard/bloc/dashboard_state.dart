part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.init() = _Initial;
  const factory DashboardState.success() = _Success;

  const factory DashboardState.searchLoading() = _SearchLoading;
  const factory DashboardState.searchSuccess(
      List<ObservationsModel> observations) = _SearchSuccess;
  const factory DashboardState.searchFailed() = _SearchFailed;
}
