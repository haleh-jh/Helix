import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/loginController.dart';
import 'package:admin/data/repo/login_repository.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants.dart';

class LoginPanelWidget extends StatefulWidget {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey;
   TextEditingController userName= TextEditingController();
  TextEditingController password = TextEditingController();

  LoginPanelWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _LoginPanelWidgetState createState() => _LoginPanelWidgetState();
}

class _LoginPanelWidgetState extends State<LoginPanelWidget> {
 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => LoginController())
                  ],
                  child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: widget._formKey,
        child: Column(
          children: <Widget>[
            _box(widget.userName, "User name", TextInputType.text),
            _box(widget.password, "Password", TextInputType.text),
            LoginButton(scaffoldKey: widget.scaffoldKey, formKey:widget._formKey, name: widget.userName, pass: widget.password,)
          ],
        ),
      ),
    )
                );
    
 }

  Widget _box(TextEditingController controller, String label,
      TextInputType textInputType) {
    return Container(
      margin: EdgeInsets.only(top: defaultSpacing),
      child: TextFormField(
        controller: controller,
        validator: (value)=> value!.isEmpty? 'Enter your $label': null,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        keyboardType: textInputType,
        obscureText: label == 'Password' ? true : false,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }

    // "password": "id_A123456",
  // "userName": "mmm"
  
  // Widget _forgotPasswordButton() => InkWell(
  //       onTap: () {
  //         /// TODO: Add Forgot password functionality
  //       },
  //       child: Text(
  //         'Forgot Password?',
  //         style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
  //       ),
  //     );

}

class LoginButton extends StatelessWidget {

  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController pass;
  final GlobalKey<ScaffoldState> scaffoldKey;
  
  const LoginButton({
    Key? key, required this.name, required this.pass, required this.formKey, required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32.0, bottom: defaultSpacing),
      child: InkWell(
    onTap: (){
            if (formKey.currentState!.validate()) {
              context.read<LoginController>().setValue(true);
              Future.delayed(Duration(milliseconds: 2000)).then(
                (value) {
                  login(scaffoldKey ,name.text.toString(), pass.text.toString(), context);
                },
              );
    }},
    child: Container(
      height: buttonHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultSpacing),
      ),
      child: Center(
        child: 
        context.watch<LoginController>().listenableValue ? 
        SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: Colors.white,))
        :
         Text(
          'Login',
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
          )
    );
  }
}

  Future<void> login(GlobalKey<ScaffoldState> scaffoldKey, String userName, String password, BuildContext context) async {

    try{
    var token = await loginRepository
        .login(userName: userName, password: password)
        .then((value) => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MainScreen())));
    PreferenceUtils.setString("token", token.toString());
    PreferenceUtils.reload();
    }catch(e){
    scaffoldKey.currentState!.showSnackBar(CustomSnackbar.customErrorSnackbar("some error occured", context));
    }
    context.read<LoginController>().setValue(false);
    print("token1: ${PreferenceUtils.getString("token")}");
      }
