// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DashboardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? search,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Search value) search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Search value)? search,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Search value)? search,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardEventCopyWith<$Res> {
  factory $DashboardEventCopyWith(
          DashboardEvent value, $Res Function(DashboardEvent) then) =
      _$DashboardEventCopyWithImpl<$Res, DashboardEvent>;
}

/// @nodoc
class _$DashboardEventCopyWithImpl<$Res, $Val extends DashboardEvent>
    implements $DashboardEventCopyWith<$Res> {
  _$DashboardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$_Started>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'DashboardEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() search,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? search,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? search,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Search value) search,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Search value)? search,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Search value)? search,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements DashboardEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$$_SearchCopyWith<$Res> {
  factory _$$_SearchCopyWith(_$_Search value, $Res Function(_$_Search) then) =
      __$$_SearchCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SearchCopyWithImpl<$Res>
    extends _$DashboardEventCopyWithImpl<$Res, _$_Search>
    implements _$$_SearchCopyWith<$Res> {
  __$$_SearchCopyWithImpl(_$_Search _value, $Res Function(_$_Search) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Search implements _Search {
  const _$_Search();

  @override
  String toString() {
    return 'DashboardEvent.search()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Search);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() search,
  }) {
    return search();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? search,
  }) {
    return search?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Search value) search,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Search value)? search,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Search value)? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class _Search implements DashboardEvent {
  const factory _Search() = _$_Search;
}

/// @nodoc
mixin _$DashboardState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() success,
    required TResult Function() searchLoading,
    required TResult Function(List<ObservationsModel> observations)
        searchSuccess,
    required TResult Function() searchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? success,
    TResult? Function()? searchLoading,
    TResult? Function(List<ObservationsModel> observations)? searchSuccess,
    TResult? Function()? searchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? success,
    TResult Function()? searchLoading,
    TResult Function(List<ObservationsModel> observations)? searchSuccess,
    TResult Function()? searchFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) init,
    required TResult Function(_Success value) success,
    required TResult Function(_SearchLoading value) searchLoading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_SearchFailed value) searchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? init,
    TResult? Function(_Success value)? success,
    TResult? Function(_SearchLoading value)? searchLoading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_SearchFailed value)? searchFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? init,
    TResult Function(_Success value)? success,
    TResult Function(_SearchLoading value)? searchLoading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_SearchFailed value)? searchFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
          DashboardState value, $Res Function(DashboardState) then) =
      _$DashboardStateCopyWithImpl<$Res, DashboardState>;
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'DashboardState.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() success,
    required TResult Function() searchLoading,
    required TResult Function(List<ObservationsModel> observations)
        searchSuccess,
    required TResult Function() searchFailed,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? success,
    TResult? Function()? searchLoading,
    TResult? Function(List<ObservationsModel> observations)? searchSuccess,
    TResult? Function()? searchFailed,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? success,
    TResult Function()? searchLoading,
    TResult Function(List<ObservationsModel> observations)? searchSuccess,
    TResult Function()? searchFailed,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) init,
    required TResult Function(_Success value) success,
    required TResult Function(_SearchLoading value) searchLoading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_SearchFailed value) searchFailed,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? init,
    TResult? Function(_Success value)? success,
    TResult? Function(_SearchLoading value)? searchLoading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_SearchFailed value)? searchFailed,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? init,
    TResult Function(_Success value)? success,
    TResult Function(_SearchLoading value)? searchLoading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_SearchFailed value)? searchFailed,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _Initial implements DashboardState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_SuccessCopyWith<$Res> {
  factory _$$_SuccessCopyWith(
          _$_Success value, $Res Function(_$_Success) then) =
      __$$_SuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SuccessCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$_Success>
    implements _$$_SuccessCopyWith<$Res> {
  __$$_SuccessCopyWithImpl(_$_Success _value, $Res Function(_$_Success) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Success implements _Success {
  const _$_Success();

  @override
  String toString() {
    return 'DashboardState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Success);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() success,
    required TResult Function() searchLoading,
    required TResult Function(List<ObservationsModel> observations)
        searchSuccess,
    required TResult Function() searchFailed,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? success,
    TResult? Function()? searchLoading,
    TResult? Function(List<ObservationsModel> observations)? searchSuccess,
    TResult? Function()? searchFailed,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? success,
    TResult Function()? searchLoading,
    TResult Function(List<ObservationsModel> observations)? searchSuccess,
    TResult Function()? searchFailed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) init,
    required TResult Function(_Success value) success,
    required TResult Function(_SearchLoading value) searchLoading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_SearchFailed value) searchFailed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? init,
    TResult? Function(_Success value)? success,
    TResult? Function(_SearchLoading value)? searchLoading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_SearchFailed value)? searchFailed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? init,
    TResult Function(_Success value)? success,
    TResult Function(_SearchLoading value)? searchLoading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_SearchFailed value)? searchFailed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements DashboardState {
  const factory _Success() = _$_Success;
}

/// @nodoc
abstract class _$$_SearchLoadingCopyWith<$Res> {
  factory _$$_SearchLoadingCopyWith(
          _$_SearchLoading value, $Res Function(_$_SearchLoading) then) =
      __$$_SearchLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SearchLoadingCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$_SearchLoading>
    implements _$$_SearchLoadingCopyWith<$Res> {
  __$$_SearchLoadingCopyWithImpl(
      _$_SearchLoading _value, $Res Function(_$_SearchLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SearchLoading implements _SearchLoading {
  const _$_SearchLoading();

  @override
  String toString() {
    return 'DashboardState.searchLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SearchLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() success,
    required TResult Function() searchLoading,
    required TResult Function(List<ObservationsModel> observations)
        searchSuccess,
    required TResult Function() searchFailed,
  }) {
    return searchLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? success,
    TResult? Function()? searchLoading,
    TResult? Function(List<ObservationsModel> observations)? searchSuccess,
    TResult? Function()? searchFailed,
  }) {
    return searchLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? success,
    TResult Function()? searchLoading,
    TResult Function(List<ObservationsModel> observations)? searchSuccess,
    TResult Function()? searchFailed,
    required TResult orElse(),
  }) {
    if (searchLoading != null) {
      return searchLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) init,
    required TResult Function(_Success value) success,
    required TResult Function(_SearchLoading value) searchLoading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_SearchFailed value) searchFailed,
  }) {
    return searchLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? init,
    TResult? Function(_Success value)? success,
    TResult? Function(_SearchLoading value)? searchLoading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_SearchFailed value)? searchFailed,
  }) {
    return searchLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? init,
    TResult Function(_Success value)? success,
    TResult Function(_SearchLoading value)? searchLoading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_SearchFailed value)? searchFailed,
    required TResult orElse(),
  }) {
    if (searchLoading != null) {
      return searchLoading(this);
    }
    return orElse();
  }
}

abstract class _SearchLoading implements DashboardState {
  const factory _SearchLoading() = _$_SearchLoading;
}

/// @nodoc
abstract class _$$_SearchSuccessCopyWith<$Res> {
  factory _$$_SearchSuccessCopyWith(
          _$_SearchSuccess value, $Res Function(_$_SearchSuccess) then) =
      __$$_SearchSuccessCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ObservationsModel> observations});
}

/// @nodoc
class __$$_SearchSuccessCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$_SearchSuccess>
    implements _$$_SearchSuccessCopyWith<$Res> {
  __$$_SearchSuccessCopyWithImpl(
      _$_SearchSuccess _value, $Res Function(_$_SearchSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? observations = null,
  }) {
    return _then(_$_SearchSuccess(
      null == observations
          ? _value._observations
          : observations // ignore: cast_nullable_to_non_nullable
              as List<ObservationsModel>,
    ));
  }
}

/// @nodoc

class _$_SearchSuccess implements _SearchSuccess {
  const _$_SearchSuccess(final List<ObservationsModel> observations)
      : _observations = observations;

  final List<ObservationsModel> _observations;
  @override
  List<ObservationsModel> get observations {
    if (_observations is EqualUnmodifiableListView) return _observations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_observations);
  }

  @override
  String toString() {
    return 'DashboardState.searchSuccess(observations: $observations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchSuccess &&
            const DeepCollectionEquality()
                .equals(other._observations, _observations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_observations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchSuccessCopyWith<_$_SearchSuccess> get copyWith =>
      __$$_SearchSuccessCopyWithImpl<_$_SearchSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() success,
    required TResult Function() searchLoading,
    required TResult Function(List<ObservationsModel> observations)
        searchSuccess,
    required TResult Function() searchFailed,
  }) {
    return searchSuccess(observations);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? success,
    TResult? Function()? searchLoading,
    TResult? Function(List<ObservationsModel> observations)? searchSuccess,
    TResult? Function()? searchFailed,
  }) {
    return searchSuccess?.call(observations);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? success,
    TResult Function()? searchLoading,
    TResult Function(List<ObservationsModel> observations)? searchSuccess,
    TResult Function()? searchFailed,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(observations);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) init,
    required TResult Function(_Success value) success,
    required TResult Function(_SearchLoading value) searchLoading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_SearchFailed value) searchFailed,
  }) {
    return searchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? init,
    TResult? Function(_Success value)? success,
    TResult? Function(_SearchLoading value)? searchLoading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_SearchFailed value)? searchFailed,
  }) {
    return searchSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? init,
    TResult Function(_Success value)? success,
    TResult Function(_SearchLoading value)? searchLoading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_SearchFailed value)? searchFailed,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(this);
    }
    return orElse();
  }
}

abstract class _SearchSuccess implements DashboardState {
  const factory _SearchSuccess(final List<ObservationsModel> observations) =
      _$_SearchSuccess;

  List<ObservationsModel> get observations;
  @JsonKey(ignore: true)
  _$$_SearchSuccessCopyWith<_$_SearchSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SearchFailedCopyWith<$Res> {
  factory _$$_SearchFailedCopyWith(
          _$_SearchFailed value, $Res Function(_$_SearchFailed) then) =
      __$$_SearchFailedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SearchFailedCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$_SearchFailed>
    implements _$$_SearchFailedCopyWith<$Res> {
  __$$_SearchFailedCopyWithImpl(
      _$_SearchFailed _value, $Res Function(_$_SearchFailed) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SearchFailed implements _SearchFailed {
  const _$_SearchFailed();

  @override
  String toString() {
    return 'DashboardState.searchFailed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SearchFailed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() success,
    required TResult Function() searchLoading,
    required TResult Function(List<ObservationsModel> observations)
        searchSuccess,
    required TResult Function() searchFailed,
  }) {
    return searchFailed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? success,
    TResult? Function()? searchLoading,
    TResult? Function(List<ObservationsModel> observations)? searchSuccess,
    TResult? Function()? searchFailed,
  }) {
    return searchFailed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? success,
    TResult Function()? searchLoading,
    TResult Function(List<ObservationsModel> observations)? searchSuccess,
    TResult Function()? searchFailed,
    required TResult orElse(),
  }) {
    if (searchFailed != null) {
      return searchFailed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) init,
    required TResult Function(_Success value) success,
    required TResult Function(_SearchLoading value) searchLoading,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_SearchFailed value) searchFailed,
  }) {
    return searchFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? init,
    TResult? Function(_Success value)? success,
    TResult? Function(_SearchLoading value)? searchLoading,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_SearchFailed value)? searchFailed,
  }) {
    return searchFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? init,
    TResult Function(_Success value)? success,
    TResult Function(_SearchLoading value)? searchLoading,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_SearchFailed value)? searchFailed,
    required TResult orElse(),
  }) {
    if (searchFailed != null) {
      return searchFailed(this);
    }
    return orElse();
  }
}

abstract class _SearchFailed implements DashboardState {
  const factory _SearchFailed() = _$_SearchFailed;
}
