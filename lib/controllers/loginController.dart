import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier, DiagnosticableTreeMixin {
   bool _listenableValue = false;
   bool get listenableValue => _listenableValue;

   void setValue(bool showProgress){
      _listenableValue = showProgress;
      notifyListeners();
   }

     /// Makes `Counter` readable inside the devtools by listing all of its properties
}