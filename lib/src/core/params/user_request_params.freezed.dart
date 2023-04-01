// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_request_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserRequestParams {
  String get token => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserRequestParamsCopyWith<UserRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRequestParamsCopyWith<$Res> {
  factory $UserRequestParamsCopyWith(
          UserRequestParams value, $Res Function(UserRequestParams) then) =
      _$UserRequestParamsCopyWithImpl<$Res, UserRequestParams>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$UserRequestParamsCopyWithImpl<$Res, $Val extends UserRequestParams>
    implements $UserRequestParamsCopyWith<$Res> {
  _$UserRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserRequestParamsCopyWith<$Res>
    implements $UserRequestParamsCopyWith<$Res> {
  factory _$$_UserRequestParamsCopyWith(_$_UserRequestParams value,
          $Res Function(_$_UserRequestParams) then) =
      __$$_UserRequestParamsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$_UserRequestParamsCopyWithImpl<$Res>
    extends _$UserRequestParamsCopyWithImpl<$Res, _$_UserRequestParams>
    implements _$$_UserRequestParamsCopyWith<$Res> {
  __$$_UserRequestParamsCopyWithImpl(
      _$_UserRequestParams _value, $Res Function(_$_UserRequestParams) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$_UserRequestParams(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserRequestParams implements _UserRequestParams {
  const _$_UserRequestParams({required this.token});

  @override
  final String token;

  @override
  String toString() {
    return 'UserRequestParams(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserRequestParams &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserRequestParamsCopyWith<_$_UserRequestParams> get copyWith =>
      __$$_UserRequestParamsCopyWithImpl<_$_UserRequestParams>(
          this, _$identity);
}

abstract class _UserRequestParams implements UserRequestParams {
  const factory _UserRequestParams({required final String token}) =
      _$_UserRequestParams;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$_UserRequestParamsCopyWith<_$_UserRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}
