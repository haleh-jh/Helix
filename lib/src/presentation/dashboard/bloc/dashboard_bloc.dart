import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/core/params/shared_pref_string_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/urls.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_drop_down_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_string_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllUseCase _getAllUseCase;
  final GetStringUseCase _getStringUseCase;

  List<DataModel> get TelescopeDropDownList => _TelescopeDropDownList;
  List<DataModel> get DetectorDropDownList => _DetectorDropDownList;
  List<DataModel> get FrameDropDownList => _FrameDropDownList;
  List<DataModel> get ObjectDropDownList => _ObjectDropDownList;

  List<DataModel> _TelescopeDropDownList = [];
  List<DataModel> _DetectorDropDownList = [];
  List<DataModel> _FrameDropDownList = [];
  List<DataModel> _ObjectDropDownList = [];

  DashboardBloc(
      {required GetAllUseCase getAllUseCase,
      required GetStringUseCase getStringUseCase})
      : _getAllUseCase = getAllUseCase,
        _getStringUseCase = getStringUseCase,
        super(const _Initial()) {
    on<DashboardEvent>((event, emit) async {
      event.when(started: () {
        _init(emit);
      });
    });
  }

  _init(Emitter<DashboardState> emit) async {
    String t =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicG9yeWEgcmFzIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI0MTE2NTQ1YS1jYzQ5LTQ1MzEtYmUxYy1iZTNhYTQ0ZjUyMGIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBRE1JTiIsImVtYWlsIjoiYWRtaW5AaGlsZXguY29tIiwic3ViIjoiYWRtaW5AaGlsZXguY29tIiwianRpIjoiZjM1MDQ2NzctMDUwYi00MmEyLTg1ZjItZjk4ZWIxNjU3YWVkIiwiZXhwIjoxNjgwMzUwMTQ5LCJpc3MiOiJoZWxpeC5jb20iLCJhdWQiOiJtYWhkaXlhciJ9.JafiFU0qBRI6hlC21Psz_oiHmoznh4755E0Z_Q5XoYY';

    final telescopeDataState = await _getAllUseCase(
            params: UserRequestParams(token: t), path: kTelescopeDropDown)
        .then((value) {
      value.data!.forEach((element) {
        _TelescopeDropDownList.add(DataModel.fromJson(element));
      });
    });

    if (telescopeDataState is DataFailure) {
      return;
    }

    // final detectoreDataState = await _getAllUseCase(
    //         params: UserRequestParams(token: t), path: kDetectorDropDown)
    //     .then((value) {
    //   value.data!.forEach((element) {
    //     _DetectorDropDownList.add(DataModel.fromJson(element));
    //   });
    // });

    // if (detectoreDataState is DataFailure) {
    //   return;
    // }

    // final frameDataState = await _getAllUseCase(
    //         params: UserRequestParams(token: t), path: kFrameDropDown)
    //     .then((value) {
    //   value.data!.forEach((element) {
    //     _FrameDropDownList.add(DataModel.fromJson(element));
    //   });
    // });

    // if (frameDataState is DataFailure) {
    //   return;
    // }

    // final objectDataState = await _getAllUseCase(
    //         params: UserRequestParams(token: t), path: kObjectDropDown)
    //     .then((value) {
    //   value.data!.forEach((element) {
    //     _ObjectDropDownList.add(DataModel.fromJson(element));
    //   });
    // });

    // if (objectDataState is DataFailure) {
    //   return;
    // }
    print("size: ${_TelescopeDropDownList.length}");
    emit(DashboardState.success(_TelescopeDropDownList, _DetectorDropDownList,
        _FrameDropDownList, _ObjectDropDownList));
  }
}
