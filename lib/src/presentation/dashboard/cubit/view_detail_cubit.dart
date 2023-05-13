import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/http_client.dart';
import 'package:helix_with_clean_architecture/src/domain/usecases/get_download_file_usecase.dart';

import '../../../core/params/user_request_params.dart';

part 'view_detail_state.dart';
part 'view_detail_cubit.freezed.dart';

class ViewDetailCubit extends Cubit<ViewDetailState> {
  final GetDownloadFileUseCase _getDownloadFileUseCase;

  String imgUrl = '';
  ValueNotifier<List<String>> downloadList = ValueNotifier([]);

  ViewDetailCubit({
    required GetDownloadFileUseCase getDownloadFileUseCase,
  })  : _getDownloadFileUseCase = getDownloadFileUseCase,
        super(const ViewDetailState.initial());

  Future getDownloadedFile(String id) async {
    String t =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoicG9yeWEgcmFzIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZWlkZW50aWZpZXIiOiI0MTE2NTQ1YS1jYzQ5LTQ1MzEtYmUxYy1iZTNhYTQ0ZjUyMGIiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBRE1JTiIsImVtYWlsIjoiYWRtaW5AaGlsZXguY29tIiwic3ViIjoiYWRtaW5AaGlsZXguY29tIiwianRpIjoiZjM1MDQ2NzctMDUwYi00MmEyLTg1ZjItZjk4ZWIxNjU3YWVkIiwiZXhwIjoxNjgwMzUwMTQ5LCJpc3MiOiJoZWxpeC5jb20iLCJhdWQiOiJtYWhkaXlhciJ9.JafiFU0qBRI6hlC21Psz_oiHmoznh4755E0Z_Q5XoYY';

    final telescopeDataState = await _getDownloadFileUseCase(
            params: UserRequestParams(token: t), data: id)
        .then((list) {
      if (list.data!.isNotEmpty) {
        String fileName = list.data![0].replaceFirst('.fits', '');
        imgUrl = "${BaseUrl}UploadedFiles/$id/thumb/${fileName}.jpeg";
        print("imgUrl: $imgUrl");
        downloadList.value = list.data!;
      }
    });
  }
}
