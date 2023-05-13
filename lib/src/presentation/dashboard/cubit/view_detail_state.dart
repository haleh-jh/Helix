part of 'view_detail_cubit.dart';

@freezed
class ViewDetailState with _$ViewDetailState {
  const factory ViewDetailState.initial() = _Initial;
  const factory ViewDetailState.success(List<String> list, String imgUrl) = _Success;
}
