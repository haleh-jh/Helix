import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/cubit/main_screen_cubit.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/widgets/side_menu.dart';

late BuildContext mainContext;
ValueNotifier<String> UserData = ValueNotifier('');
ValueNotifier<String> UserType = ValueNotifier('GENERAL');

 const int dashboardIndex = 0;
 const int telescopsIndex = 1;
 const int detectorsIndex = 2;
 const int objectsIndex = 3;
 const int FiltersIndex = 4;
 const int observationsIndex = 5;
 const int usersIndex = 6;
 const int profileIndex = 7;
 const int settingsIndex = 8;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

final bloc = injector<MainScreenCubit>();

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      bloc: bloc,
      builder: (context, state) {
        bloc.loadPages(context);
        return WillPopScope(
          onWillPop: bloc.onWillPop,
          child: state.when(
            initial: () {
              return Scaffold(
                key: bloc.scaffoldKey,
                drawer: SideMenu(
                  selectedIndex: 0,
                  onTap: bloc.changeScreen,
                ),
                body: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Responsive.isDesktop(context))
                        Expanded(
                          child: SideMenu(
                            selectedIndex: 0,
                            onTap: bloc.changeScreen,
                          ),
                        ),
                      Expanded(
                          flex: 5,
                          child: IndexedStack(
                            key: ObjectKey(bloc.pages[0].hashCode),
                            index: 0,
                            children: bloc.pages,
                          )),
                    ],
                  ),
                ),
              );
            },
            changeScreenState: (int selectedScreen) {
              return Scaffold(
                key: bloc.scaffoldKey,
                drawer: SideMenu(
                  selectedIndex: selectedScreen,
                  onTap: bloc.changeScreen,
                ),
                body: SafeArea(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Responsive.isDesktop(context))
                        Expanded(
                          child: SideMenu(
                            selectedIndex: selectedScreen,
                            onTap: bloc.changeScreen,
                          ),
                        ),
                      Expanded(
                          flex: 5,
                          child: IndexedStack(
                            key: ObjectKey(bloc.pages[0].hashCode),
                            index: selectedScreen,
                            children: bloc.pages,
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
