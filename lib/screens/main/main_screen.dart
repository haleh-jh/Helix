import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/data/repo/login_repository.dart';
import 'package:admin/main.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/detectors_screen.dart';
import 'package:admin/screens/dashboard/frames_screen.dart';
import 'package:admin/screens/dashboard/objects_screen.dart';
import 'package:admin/screens/dashboard/observations_screen.dart';
import 'package:admin/screens/dashboard/profile_screen.dart';
import 'package:admin/screens/dashboard/settings_screen.dart';
import 'package:admin/screens/dashboard/telescop_screen.dart';
import 'package:admin/screens/dashboard/users_screen.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int dashboardIndex = 0;
const int telescopsIndex = 1;
const int detectorsIndex = 2;
const int objectsIndex = 3;
const int framesIndex = 4;
const int observationsIndex = 5;
const int usersIndex = 6;
const int profileIndex = 7;
const int settingsIndex = 8;

ValueNotifier<String> UserData = ValueNotifier('');
ValueNotifier<String> UserType = ValueNotifier('GENERAL');

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuController()),
        ChangeNotifierProvider(create: (context) => DataController()),
        ChangeNotifierProvider(create: (context) => ProgressController()),
      ],
      child: Body(),
    );
  }
}

class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static int selectedScreenIndex = dashboardIndex;

  List<int> _history = [];

  GlobalKey<NavigatorState> _dashboardKey = GlobalKey();

  GlobalKey<NavigatorState> _telescopsKey = GlobalKey();

  GlobalKey<NavigatorState> _detectorsKey = GlobalKey();

  GlobalKey<NavigatorState> _objectsKey = GlobalKey();

  GlobalKey<NavigatorState> _framesKey = GlobalKey();

  GlobalKey<NavigatorState> _observationsKey = GlobalKey();

  GlobalKey<NavigatorState> _usersKey = GlobalKey();

  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  GlobalKey<NavigatorState> _settingsKey = GlobalKey();

  late final map = {
    dashboardIndex: _dashboardKey,
    telescopsIndex: _telescopsKey,
    detectorsIndex: _detectorsKey,
    objectsIndex: _objectsKey,
    framesIndex: _framesKey,
    usersIndex: _usersKey,
    profileIndex: _profileKey,
    settingsIndex: _settingsKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentselectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentselectedTabNavigatorState.canPop()) {
      currentselectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {

    if(logged){
         getUser();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(
          selectedIndex: selectedScreenIndex,
          onTap: changeScreen,
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(
                    selectedIndex: selectedScreenIndex,
                    onTap: changeScreen,
                  ),
                ),
              Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: IndexedStack(
                    index: selectedScreenIndex,
                    children: [
                      _navigator(
                          _dashboardKey, dashboardIndex, DashboardScreen(profileSelected: changeScreen, logout: (){
                              PreferenceUtils.clear();
                              PreferenceUtils.reload();
                                  logged = false;
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => true);
                          },)),
                      _navigator(
                          _telescopsKey, telescopsIndex, TelescopScreen()),
                      _navigator(
                          _detectorsKey, detectorsIndex, DetectorScreen()),
                      _navigator(_objectsKey, objectsIndex, ObjectsScreen()),
                      _navigator(_framesKey, framesIndex, FramesScreen()),
                      _navigator(_observationsKey, observationsIndex, ObservationsScreen()),
                      if(UserType.value.contains("ADMIN")) _navigator(_usersKey, usersIndex, UsersScreen()),
                      _navigator(_profileKey, profileIndex, ProfileScreen()),
                      _navigator(_settingsKey, settingsIndex, SettingsScreen()),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  changeScreen(int index){
    print("changeScreen $index");
  _history.remove(selectedScreenIndex);
            _history.add(selectedScreenIndex);
            setState(() {
              selectedScreenIndex = index;
            });
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                      offstage: selectedScreenIndex != index,
                      child: child,
                    )));
  }

  Future<void> getUser() async {
  try {
    var token = PreferenceUtils.getString("token");
   
      await loginRepository
        .getUser(token!)
        .then((user) {
             print("getUser: ${user.type}");
          UserData.value = "${user.surname} ${user.lastName}" ;
          UserType.value = "${user.type}" ;
          PreferenceUtils.saveUserData(user);
    });
  } catch (e) {
    print("catch: ${e.toString()}");
     Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
  }
}
}
