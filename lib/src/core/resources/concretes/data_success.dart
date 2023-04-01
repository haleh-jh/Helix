
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  List<Object?> get props => [data];
}
