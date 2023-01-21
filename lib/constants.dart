import 'dart:html';

import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const double defaultSpacing = 16.0;
const double buttonHeight = 50.0;
const double fontSize = 18.0;

const kMainLightColor = Color(0xffffffff);
const kPlaceholderColor = Color.fromARGB(255, 98, 98, 98);
const kSubTitleColor = Color(0xffaeabbb);
const kButtonColor = Color(0xfff6f5fb);
const kCustomElevatedButtonColor = Color(0xff5f57de);
const kIconColor = Color(0xff6f64b7);
const kBackgroundColor = Color(0xfff6f5fb);
const kCursorTextFieldColor = Color(0xff9896be);
const kOrangeColor = Color(0xffff9f00);
const kDeleteIconColor = Color(0xffff4343);
const kEditIconColor = Color(0xff19e9aa);
const serachBackground = Color.fromRGBO(73, 78, 108,1);

// const Color green300 = Color(0xFF81C784);
// const Color green400 = Color(0xFF66BB6A);

const defaultPadding = 16.0;
const height = 40.0;

String defaultError = "An error has occurred";

final String telescope = "Optics";
final String telescopePath = "Telescopes";
final String telescopeDropDown = "Telescopes/GetDropDownTelescopes";
final String detectorDropDown = "Detectors/GetDropDownDetectors";
final String objectDropDown = "SObjects/GetDropDownSObjects";
final String frameDropDown = "Filters/GetDropDownDetectors";
final String detector = "Detectors";
final String Objects = "SObjects";
final String Users = "Users";
final String ObservationsPath = "ObservationSubmissions";
final String Filters = "Filters";

const String kServerError= "خطایی از سمت سرور رخ داده است.";
const String kGeneralError= "خطایی رخ داده است مجدد امتحان نمایید.";
const String kConnectionError= "Check your internet connection";


bool? checkConnection(){
  return window.navigator.onLine;
}

