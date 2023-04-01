import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/info.dart';
part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
abstract class DataModel with _$DataModel{
    const DataModel._();
  const factory DataModel({
        required int key,
      required String value,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);

  Info toEntity() => Info(key: key, value: value);
}