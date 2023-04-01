import 'package:freezed_annotation/freezed_annotation.dart';
part 'info.freezed.dart';

@freezed
abstract class Info with _$Info{
   const factory Info({
    required int key,
      required String value,
   }) = _Info;
  }