import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

bool logged = false;
String token ="";
// late ValueNotifier<bool> logged = ValueNotifier(false);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  if (PreferenceUtils.getString("token") != null && PreferenceUtils.getString("token")!.length>0) {
    logged = true;
    token = PreferenceUtils.getString("token")!;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
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
          // MainScreen()
           logged? MainScreen() : LoginScreen(),
          );
    });
  }
}
