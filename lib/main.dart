
import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/data/repo/login_repository.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

bool logged = false;
String token = "";
ValueNotifier<String> CheckInternet = ValueNotifier('');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  if (PreferenceUtils.getString("token") != null &&
      PreferenceUtils.getString("token")!.length > 0) {
    logged = true;
    token = PreferenceUtils.getString("token")!;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    if (PreferenceUtils.getString("token") != null &&
        PreferenceUtils.getString("token")!.length > 0) {
      getUser(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget v;
    if (PreferenceUtils.getString("token") != null &&
        PreferenceUtils.getString("token")!.length > 0) {
      v = MainScreen();
    } else
      v = LoginScreen();
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
          home: v);
    });
  }
}

Future<void> getUser(BuildContext context) async {
  try {
    var token = PreferenceUtils.getString("token");

    await loginRepository.getUser(token!).then((user) {
      UserData.value = "${user.surname} ${user.lastName}";
      UserType.value = "${user.type}";
      PreferenceUtils.saveUserData(user);
    });
  } catch (e) {
        String error = '';
    if(e is AppException){
          print(e.message.toString());
          error = e.message;
    }else error = kGeneralError;

    ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.customErrorSnackbar(error, context));
  }
}
