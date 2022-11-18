import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/ProgressController.dart';
import 'package:admin/screens/dashboard/telescop_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const SideMenu({
    Key? key, required this.selectedIndex, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // DrawerHeader(
          //   child: Image.asset("assets/images/logo.png"),
          // ),
          SizedBox(height: 30,),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              onTap(dashboardIndex);
            },
          ),
          DrawerListTile(
            title: "Telescops",
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
            title: "Frames",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              onTap(framesIndex);
            },
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              onTap(usersIndex);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              onTap(profileIndex);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              onTap(settingsIndex);
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
    // For selecting those three line once press "Command+D"
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
