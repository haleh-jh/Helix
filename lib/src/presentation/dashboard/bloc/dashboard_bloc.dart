import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/core/params/user_request_params.dart';
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';
import 'package:helix_with_clean_architecture/src/core/resources/concretes/data_failure.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/urls.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_drop_down_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_string_usecase.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/search_usecase.dart';

import '../../../core/params/shared_pref_string_request_params.dart';
import '../../../domain/usecases/set_string_usecase.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';
part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllUseCase _getAllUseCase;
  final GetStringUseCase _getStringUseCase;
  final SearchUseCase _searchUseCase;
  final SetStringUseCase _setStringUseCase;

  List<DataModel> get TelescopeDropDownList => _TelescopeDropDownList;
  List<DataModel> get DetectorDropDownList => _DetectorDropDownList;
  List<DataModel> get FrameDropDownList => _FrameDropDownList;
  List<DataModel> get ObjectDropDownList => _ObjectDropDownList;

  List<DataModel> _TelescopeDropDownList = [];
  List<DataModel> _DetectorDropDownList = [];
  List<DataModel> _FrameDropDownList = [];
  List<DataModel> _ObjectDropDownList = [];

  bool searchResult = false;

  DashboardBloc({
    required GetAllUseCase getAllUseCase,
    required GetStringUseCase getStringUseCase,
    required SearchUseCase searchUseCase,
    required SetStringUseCase setStringUseCase
  })  : _getAllUseCase = getAllUseCase,
        _getStringUseCase = getStringUseCase,
        _searchUseCase = searchUseCase,
        _setStringUseCase = setStringUseCase,
        super(const _Initial()) {
    on<DashboardEvent>((event, emit) async {
      if (event == const DashboardEvent.started()) {
        try {
          await _init()
              .whenComplete(() => emit(const DashboardState.success()));
        } catch (e) {}
      }
    });
  }

  Future _init() async {
    print("check");
    DataState<String> t = await _getStringUseCase(
      params: SharedPrefStringRequestParams(key: 'token'),
    );
      //  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicG9yeWEgcmFzIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI0MTE2NTQ1YS1jYzQ5LTQ1MzEtYmUxYy1iZTNhYTQ0ZjUyMGIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBRE1JTiIsImVtYWlsIjoiYWRtaW5AaGlsZXguY29tIiwic3ViIjoiYWRtaW5AaGlsZXguY29tIiwianRpIjoiZjM1MDQ2NzctMDUwYi00MmEyLTg1ZjItZjk4ZWIxNjU3YWVkIiwiZXhwIjoxNjgwMzUwMTQ5LCJpc3MiOiJoZWxpeC5jb20iLCJhdWQiOiJtYWhkaXlhciJ9.JafiFU0qBRI6hlC21Psz_oiHmoznh4755E0Z_Q5XoYY';
    if(t is DataFailure){
      return;
    }

    _TelescopeDropDownList = [];
    _DetectorDropDownList = [];
    _FrameDropDownList = [];
    _ObjectDropDownList = [];

    final telescopeDataState = await _getAllUseCase(
            params: UserRequestParams(token: t.data!), data: kTelescopeDropDown)
        .then((value) {
      value.data!.forEach((element) {
        _TelescopeDropDownList.add(DataModel.fromJson(element));
      });
    });

    if (telescopeDataState is DataFailure) {
      return;
    }

    final detectoreDataState = await _getAllUseCase(
            params: UserRequestParams(token: t.data!), data: kDetectorDropDown)
        .then((value) {
      value.data!.forEach((element) {
        _DetectorDropDownList.add(DataModel.fromJson(element));
      });
    });

    if (detectoreDataState is DataFailure) {
      return;
    }

    final frameDataState = await _getAllUseCase(
            params: UserRequestParams(token: t.data!), data: kFrameDropDown)
        .then((value) {
      value.data!.forEach((element) {
        _FrameDropDownList.add(DataModel.fromJson(element));
      });
    });

    if (frameDataState is DataFailure) {
      return;
    }

    final objectDataState = await _getAllUseCase(
            params: UserRequestParams(token: t.data!), data: kObjectDropDown)
        .then((value) {
      value.data!.forEach((element) {
        _ObjectDropDownList.add(DataModel.fromJson(element));
      });
    });

    if (objectDataState is DataFailure) {
      return;
    }
  }

  onSearch(dynamic value) async {
    try {
      //   loading.value = true;
          DataState<String> t = await _getStringUseCase(
      params: SharedPrefStringRequestParams(key: 'token'),
    );
      // String t =
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicG9yeWEgcmFzIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI0MTE2NTQ1YS1jYzQ5LTQ1MzEtYmUxYy1iZTNhYTQ0ZjUyMGIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBRE1JTiIsImVtYWlsIjoiYWRtaW5AaGlsZXguY29tIiwic3ViIjoiYWRtaW5AaGlsZXguY29tIiwianRpIjoiZjM1MDQ2NzctMDUwYi00MmEyLTg1ZjItZjk4ZWIxNjU3YWVkIiwiZXhwIjoxNjgwMzUwMTQ5LCJpc3MiOiJoZWxpeC5jb20iLCJhdWQiOiJtYWhkaXlhciJ9.JafiFU0qBRI6hlC21Psz_oiHmoznh4755E0Z_Q5XoYY';
       await _searchUseCase(params: UserRequestParams(token: t.data!), data: value)
          .then((value) {
        if (value.data!.isEmpty) {
          searchResult = true;
        } else {
          searchResult = false;
        }
        emit(DashboardState.searchSuccess(value.data!));
      });
    } catch (e) {
      //   loading.value = false;
    }
  }
}
