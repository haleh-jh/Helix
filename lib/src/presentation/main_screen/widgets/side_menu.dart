import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  SideMenu({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  final bloc = injector<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              onTap(dashboardIndex);
          //     bloc.add(const DashboardEvent.started());
            },
          ),
          DrawerListTile(
            title: "Telescopes",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              onTap(telescopsIndex);
            },
          ),
          DrawerListTile(
            title: "Detectors",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              onTap(detectorsIndex);
            },
          ),
          DrawerListTile(
            title: "Objects",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              onTap(objectsIndex);
            },
          ),
          DrawerListTile(
            title: "Filters",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              onTap(FiltersIndex);
            },
          ),
          DrawerListTile(
            title: "Observations",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              onTap(observationsIndex);
            },
          ),
          // if (UserType.value.contains("ADMIN")) ...{
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              onTap(usersIndex);
            },
          )
          //   }
          ,
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              onTap(profileIndex);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
