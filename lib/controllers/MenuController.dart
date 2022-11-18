import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _changeMenu = 0;

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get changeMenu => _changeMenu;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

   void menuChanged(int index) {
    if (_changeMenu!=index) {
      _changeMenu = index;
      notifyListeners();
    }
  }
}
