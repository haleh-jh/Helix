import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_request_params.freezed.dart';


@freezed
abstract class  UserRequestParams with _$UserRequestParams {
  const factory UserRequestParams({required String token}) = _UserRequestParams;
}