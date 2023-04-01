
import 'package:helix_with_clean_architecture/src/core/resources/abstracts/data_state.dart';

class DataFailure<T> extends DataState<T> {
  const DataFailure(String message, String title,): super(errorMessage: message,);

  @override
  List<Object?> get props => [];
}
