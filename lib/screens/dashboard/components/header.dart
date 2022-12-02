import 'package:admin/common/custom_text_field.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/profile_screen.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final String title;
  Function profileSelected;
  Function() logout;

  Header({Key? key, required this.title, required this.profileSelected, required this.logout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: logout,
              child: Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Text('Logout'),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ProfileCard(
          profileSelected: profileSelected,
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  Function profileSelected;
  ProfileCard({Key? key, required this.profileSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name =
        '${PreferenceUtils.getString('surname')}  ${PreferenceUtils.getString('lastName')}';
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileScreen()));
          // profileSelected();
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: SvgPicture.asset(
                "assets/icons/profile.svg",
                height: 38,
              ),
            ),
            if (!Responsive.isMobile(context))
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: ValueListenableBuilder<String>(
                      valueListenable: UserData,
                      builder: (context, val, _) {
                        return Text("${UserData.value}");
                      })),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
