import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/controllers/ProgressController.dart';
import 'package:admin/data/repo/login_repository.dart';
import 'package:admin/main.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class LoginPanelWidget extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController loginUserName = TextEditingController();
  TextEditingController registerUserName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController institution = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  LoginPanelWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _LoginPanelWidgetState createState() => _LoginPanelWidgetState();
}

ValueNotifier<bool> loginView = ValueNotifier(true);

class _LoginPanelWidgetState extends State<LoginPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProgressController())
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: widget._formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ValueListenableBuilder(
                      valueListenable: loginView,
                      builder: ((context, value, child) {
                        return Column(
                          children: [
                            loginView.value
                                ? LoginView(
                                    password: widget.loginPassword,
                                    userName: widget.loginUserName,
                                  )
                                : RegisterView(
                                    password: widget.registerPassword,
                                    userName: widget.registerUserName,
                                    lastName: widget.lastName,
                                    surname: widget.surname,
                                    email: widget.email,
                                    institution: widget.institution,
                                  ),
                            loginView.value
                                ? LoginButton(
                                    scaffoldKey: widget.scaffoldKey,
                                    formKey: widget._formKey,
                                    name: widget.loginUserName,
                                    pass: widget.loginPassword,
                                  )
                                : RegisterButton(
                                    scaffoldKey: widget.scaffoldKey,
                                    formKey: widget._formKey,
                                    username: widget.registerUserName,
                                    lastname: widget.lastName,
                                    surname: widget.surname,
                                    email: widget.email,
                                    institution: widget.institution,
                                    password: widget.registerPassword,
                                  ),
                            !loginView.value
                                ? InkWell(
                                    onTap: () {
                                      loginView.value = !loginView.value;
                                    },
                                    child: Text(
                                      "Do you have account?",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      loginView.value = !loginView.value;
                                    },
                                    child: Text(
                                      "I dont have account",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                          ],
                        );
                      })),
                ],
              ),
            ),
          ),
        ));
  }
}

class RegisterView extends StatelessWidget {
  RegisterView(
      {Key? key,
      required this.userName,
      required this.lastName,
      required this.surname,
      required this.email,
      required this.institution,
      required this.password})
      : super(key: key);

  final TextEditingController userName;
  final TextEditingController lastName;
  final TextEditingController surname;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController institution;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          controller: userName,
          label: "User name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: lastName,
          label: "Last name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: surname,
          label: "surname",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: email,
          label: "Email",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: password,
          label: "Password",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: institution,
          label: "Institution",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class LoginView extends StatelessWidget {
  LoginView({Key? key, required this.userName, required this.password})
      : super(key: key);

  final TextEditingController userName;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          controller: userName,
          label: "User name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: password,
          label: "Password",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

//
class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController name;
  final TextEditingController pass;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const LoginButton({
    Key? key,
    required this.name,
    required this.pass,
    required this.formKey,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 32.0, bottom: defaultSpacing),
        child: InkWell(
          onTap: () {
            if (!loginView.value) {
              loginView.value = !loginView.value;
            }
            if (formKey.currentState!.validate()) {
              context.read<ProgressController>().setValue(true);
              Future.delayed(Duration(milliseconds: 2000)).then(
                (value) {
                  login(scaffoldKey, name.text.toString(), pass.text.toString(),
                      context);
                },
              );
            }
          },
          child: Container(
            height: buttonHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(defaultSpacing),
            ),
            child: Center(
              child: context.watch<ProgressController>().listenableValue
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ));
  }
}

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController username;
  final TextEditingController lastname;
  final TextEditingController surname;
  final TextEditingController email;
  final TextEditingController institution;
  final TextEditingController password;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const RegisterButton({
    Key? key,
    required this.formKey,
    required this.scaffoldKey,
    required this.username,
    required this.lastname,
    required this.surname,
    required this.email,
    required this.institution,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0, bottom: defaultSpacing),
        child: InkWell(
          onTap: () {
            if (loginView.value) {
              loginView.value = !loginView.value;
            }
            if (formKey.currentState!.validate()) {
              context.read<ProgressController>().setValue(true);
              Future.delayed(Duration(milliseconds: 2000)).then(
                (value) {
                  register(
                      scaffoldKey,
                      email.text.toString(),
                      lastname.text.toString(),
                      password.text.toString(),
                      surname.text.toString(),
                      username.text.toString(),
                      institution.text.toString(),
                      context);
                },
              );
            }
          },
          child: Container(
            height: buttonHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(defaultSpacing),
            ),
            child: Center(
              child: context.watch<ProgressController>().listenableValue
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                  : Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ));
  }
}

Future<void> login(GlobalKey<ScaffoldState> scaffoldKey, String userName,
    String password, BuildContext context) async {
  try {
    var token = await loginRepository
        .login(userName: userName, password: password)
        .then((value) async {
      print("token: $value");
      await PreferenceUtils.setString("token", value);
      await PreferenceUtils.reload();
      logged = true;
      //   await getUser(context, value);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MainScreen()));
    });
  } catch (e) {
    String error = '';
    if (e is AppException) {
      print(e.message.toString());
      error = e.message;
    } else
      error = kGeneralError;

    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackbar.customErrorSnackbar(error, context));
  }
  context.read<ProgressController>().setValue(false);
}

Future<void> register(
    GlobalKey<ScaffoldState> scaffoldKey,
    String email,
    String lastname,
    String password,
    String surname,
    String username,
    String institution,
    BuildContext context) async {
  try {
    await loginRepository
        .register(
            context, email, lastname, password, surname, username, institution)
        .then((value) async {
      if (value.toString().contains('User Created.')) {
        await login(scaffoldKey, username, password, context);
      }
    });
  } catch (e) {
    String error = '';
    if (e is AppException) {
      print(e.message.toString());
      error = e.message;
    } else
      error = kGeneralError;

    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackbar.customErrorSnackbar(error, context));
  }
  context.read<ProgressController>().setValue(false);
}

Future<void> getUser(BuildContext context, String token) async {
  try {
    await loginRepository.getUser(token).then((user) {
      UserData.value = "${user.surname} ${user.lastName}";
      UserType.value = "${user.type}";
      PreferenceUtils.saveUserData(user);
    });
  } catch (e) {}
}
