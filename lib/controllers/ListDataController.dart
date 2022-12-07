import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListDataController<T> with ChangeNotifier, DiagnosticableTreeMixin {
  List<T> _detectorlist = [];
  List<T> get detectorlist => _detectorlist;

  String _detectorValue = '';
  String get detectorValue => _detectorValue;

  List<T> _telescopelist = [];
  List<T> get telescopelist => _telescopelist;

  String _telescopeValue = '';
  String get telescopeValue => _telescopeValue;

  List<T> _objectlist = [];
  List<T> get objectlist => _objectlist;

  String _objectValue = '';
  String get objectValue => _objectValue;

  List<T> _framelist = [];
  List<T> get framelist => _framelist;

  String _frameValue = '';
  String get frameValue => _frameValue;

  void telescopeSetValue(List<T> list) {
    _telescopelist = list;
    notifyListeners();
  }

  void telescopeSetSValue(String v) {
    _telescopeValue = v;
    notifyListeners();
  }

  void detectorSetValue(List<T> list) {
    _detectorlist = list;
    notifyListeners();
  }

  void detectorSetSValue(String v) {
    _detectorValue = v;
    notifyListeners();
  }

  void objectSetValue(List<T> list) {
    _objectlist = list;
    notifyListeners();
  }

  void objectSetSValue(String v) {
    _objectValue = v;
    notifyListeners();
  }

  void frameSetValue(List<T> list) {
    _framelist = list;
    notifyListeners();
  }

  void frameSetSValue(String v) {
    _frameValue = v;
    notifyListeners();
  }
}
