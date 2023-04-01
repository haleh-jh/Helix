

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/cubit/main_screen_cubit.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';

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
            onPressed: context.read<MainScreenCubit>().controlMenu,
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
            TextIconButton(logout: logout),
          ],
        ),
        ProfileCard(
          profileSelected: profileSelected,
        )
      ],
    );
  }
}

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.logout,
  }) : super(key: key);

  final Function() logout;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: logout,
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 0.75),
        margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: const[
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
    );
  }
}

class ProfileCard extends StatelessWidget {
  Function profileSelected;
  ProfileCard({Key? key, required this.profileSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = '';
       // '${PreferenceUtils.getString('surname')}  ${PreferenceUtils.getString('lastName')}';
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
