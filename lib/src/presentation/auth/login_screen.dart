import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/presentation/auth/widgets/login_panel.dart';
import 'package:helix_with_clean_architecture/src/presentation/auth/widgets/login_wave.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: defaultSpacing),
            height: h / 1.5,
            width: w,
            child: ClipPath(
              clipper: WaveClipper(),
              child: const ColoredBox(
                color: primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: h / 8, left: defaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                 Text(
                  "Welcome To\nHelix Project",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Responsive(
            mobile: Container(
              margin: EdgeInsets.only(top: h / 2.5),
              alignment: Alignment.center,
              child: LoginPanelWidget( scaffoldKey: _scaffoldKey),
            ),
            tablet: Container(
              margin: EdgeInsets.only(top: h / 2.5, left: w/4, right: w/4),
              alignment: Alignment.center,
              child: LoginPanelWidget( scaffoldKey: _scaffoldKey),
            ),
            desktop: Container(
              margin: EdgeInsets.only(top: h / 2.5, left: w/4, right: w/4),
              alignment: Alignment.center,
              child: LoginPanelWidget( scaffoldKey: _scaffoldKey,),
            ),
          ),
        ],
      ),
    );
  
  }
}
