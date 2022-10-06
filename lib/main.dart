import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

 bool logged = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await ScreenUtil.ensureScreenSize();
  print("token: ${await PreferenceUtils.getString("token")}");
  if (await PreferenceUtils.getString("token") != null) {
      logged = true;
    }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: 
   //   MainScreen()
     logged? MainScreen() : LoginScreen(),
    );
  }
}
