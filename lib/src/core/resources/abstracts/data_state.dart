import 'package:equatable/equatable.dart';


abstract class DataState<T> extends Equatable {
  final T? data;
 // final Fail? failure;
 final String? errorMessage;
 final String? errorTitle;
 final String? errorCode;

  const DataState({this.data, this.errorCode, this.errorMessage, this.errorTitle});
}
