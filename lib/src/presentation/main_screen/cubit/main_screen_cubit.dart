import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:helix_with_clean_architecture/src/presentation/auth/login_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/dashboard_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/detector/detector_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/filter/filter_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/object/object_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/observation/observation_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/profile/profile_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/telesope/telescope_screen.dart';
import 'package:helix_with_clean_architecture/src/presentation/user/user_screen.dart';

part 'main_screen_state.dart';
part 'main_screen_cubit.freezed.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState.initial());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List<Widget> get pages => _pages;
  List<Widget> _pages = [];

  List<int> _history = [];

  GlobalKey<NavigatorState> _dashboardKey = GlobalKey();
  GlobalKey<NavigatorState> _telescopsKey = GlobalKey();
  GlobalKey<NavigatorState> _detectorsKey = GlobalKey();
  GlobalKey<NavigatorState> _objectsKey = GlobalKey();
  GlobalKey<NavigatorState> _FiltersKey = GlobalKey();
  GlobalKey<NavigatorState> _observationsKey = GlobalKey();
  GlobalKey<NavigatorState> _usersKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();
  GlobalKey<NavigatorState> _settingsKey = GlobalKey();

  int get selectedScreenIndex => _selectedScreenIndex;
  int _selectedScreenIndex = 0;

  ValueNotifier<String> UserData = ValueNotifier('');
  ValueNotifier<String> UserType = ValueNotifier('GENERAL');

  late final map = {
    dashboardIndex: _dashboardKey,
    telescopsIndex: _telescopsKey,
    detectorsIndex: _detectorsKey,
    objectsIndex: _objectsKey,
    FiltersIndex: _FiltersKey,
    usersIndex: _usersKey,
    profileIndex: _profileKey,
    settingsIndex: _settingsKey,
  };

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                  builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index,
                    child: child,
                  ),
                  maintainState: false,
                ));
  }

  void loadPages(BuildContext context) {
    _pages = [
      _navigator(
          _dashboardKey,
          dashboardIndex,
          DashboardScreen(
              profileSelected: changeScreen,
              logout: () {
                // PreferenceUtils.clear();
                // PreferenceUtils.reload();
                // logged = false;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => true);
              },
              )),
      _navigator(_telescopsKey, telescopsIndex, TelescopeScreen()),
      _navigator(_detectorsKey, detectorsIndex, DetectorScreen()),
      _navigator(_objectsKey, objectsIndex, ObjectScreen()),
      _navigator(_FiltersKey, FiltersIndex, FilterScreen()),
      _navigator(_observationsKey, observationsIndex, ObservationScreen()),
      if (UserType.value.contains("ADMIN"))
        _navigator(_usersKey, usersIndex, UserScreen()),
      _navigator(_profileKey, profileIndex, ProfileScreen()),
    ];
  }

  changeScreen(int index) {
    print("changeScreen $index");
    _history.remove(selectedScreenIndex);
    _history.add(selectedScreenIndex);
    _selectedScreenIndex = index;
    emit(MainScreenState.changeScreenState(_selectedScreenIndex));
  }

  Future<bool> onWillPop() async {
    final NavigatorState currentselectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentselectedTabNavigatorState.canPop()) {
      currentselectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      _selectedScreenIndex = _history.last;
      _history.removeLast();
      emit(MainScreenState.changeScreenState(_selectedScreenIndex));
      return false;
    } else {
      return true;
    }
  }

    void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
