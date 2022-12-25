import 'dart:convert';

import 'package:admin/screens/login/components/login_panel.dart';
import 'package:admin/screens/login/components/login_wave.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';

class LoginScreen extends StatefulWidget {
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
            padding: EdgeInsets.only(bottom: defaultSpacing),
            height: h / 1.5,
            width: w,
            child: ClipPath(
              clipper: WaveClipper(),
              child: ColoredBox(
                color: primaryColor,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: h / 8, left: defaultSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Welcome To\nHelix ",
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
