part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.init() = _Initial;
    const factory DashboardState.success(
    List<DataModel> telescopeList,
    List<DataModel> detectorList,
    List<DataModel> frameList,
    List<DataModel> objectList,
  ) = _Success;
  
}
