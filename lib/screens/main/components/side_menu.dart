import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/ProgressController.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard/telescop_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const SideMenu({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataController myProvider =
        Provider.of<DataController>(context, listen: false);
    return ValueListenableBuilder(
        valueListenable: UserType,
        builder: (context, value, child) {
          return Drawer(
            child: ListView(
              children: [
                // DrawerHeader(
                //   child: Image.asset("assets/images/logo.png"),
                // ),
                SizedBox(
                  height: 30,
                ),
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashbord.svg",
                  press: () {
                    myProvider.getTelescopeDropDownList.clear();
                    myProvider.getDetectorDropDownList.clear();
                    myProvider.getSObjectDropDownList.clear();
                    myProvider.getFrameDropDownList.clear();
                    telescopeValue.value = null;
                    detectorValue.value = null;
                    objectValue.value = null;
                    frameValue.value = null;
                    prepareData(context);
                    onTap(dashboardIndex);
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
                    // myProvider.getSObjectsList.clear();
                    // myProvider.getAll(
                    //     context, myProvider.getSObjectsList, Objects);
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
                if (UserType.value.contains("ADMIN")) ...{
                  DrawerListTile(
                    title: "Users",
                    svgSrc: "assets/icons/menu_notification.svg",
                    press: () {
                      onTap(usersIndex);
                    },
                  )
                },
                DrawerListTile(
                  title: "Profile",
                  svgSrc: "assets/icons/menu_profile.svg",
                  press: () {
                    onTap(profileIndex);
                  },
                ),
                // DrawerListTile(
                //   title: "Settings",
                //   svgSrc: "assets/icons/menu_setting.svg",
                //   press: () {
                //     onTap(settingsIndex);
                //   },
                // ),
              ],
            ),
          );
        });
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
