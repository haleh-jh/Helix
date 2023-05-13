import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/auth/cubit/register_cubit.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/input_box.dart';
import 'package:provider/provider.dart';

import '../cubit/login_cubit.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: widget._formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ValueListenableBuilder(
                  valueListenable: loginView,
                  builder: ((context, value, child) {
                    return loginView.value
                        ? loginViewParent(context)
                        : registerViewParent(context);
                  }))
            ],
          ),
        ),
      ),
    );
  }

  Column registerViewParent(BuildContext context) {
    return Column(
      children: [
        RegisterView(
          password: widget.registerPassword,
          userName: widget.registerUserName,
          lastName: widget.lastName,
          surname: widget.surname,
          email: widget.email,
          institution: widget.institution,
        ),
        RegisterButton(
          scaffoldKey: widget.scaffoldKey,
          formKey: widget._formKey,
          username: widget.registerUserName,
          lastname: widget.lastName,
          surname: widget.surname,
          email: widget.email,
          institution: widget.institution,
          password: widget.registerPassword,
        ),
        InkWell(
          onTap: () {
            loginView.value = !loginView.value;
          },
          child: Text(
            "Do you have account?",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  Column loginViewParent(BuildContext context) {
    return Column(
      children: [
        LoginView(
          password: widget.loginPassword,
          userName: widget.loginUserName,
        ),
        LoginButton(
          scaffoldKey: widget.scaffoldKey,
          formKey: widget._formKey,
          name: widget.loginUserName,
          pass: widget.loginPassword,
        ),
        InkWell(
          onTap: () {
            loginView.value = !loginView.value;
          },
          child: Text(
            "I dont have account",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      ],
    );
  }
}

TextStyle defStyle = const TextStyle(
    color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400);

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
            style: defStyle),
        InputBox(
            controller: lastName,
            label: "Last name",
            textInputType: TextInputType.text,
            style: defStyle),
        InputBox(
            controller: surname,
            label: "surname",
            textInputType: TextInputType.text,
            style: defStyle),
        InputBox(
            controller: email,
            label: "Email",
            textInputType: TextInputType.text,
            style: defStyle),
        InputBox(
            controller: password,
            label: "Password",
            textInputType: TextInputType.text,
            style: defStyle),
        InputBox(
            controller: institution,
            label: "Institution",
            textInputType: TextInputType.text,
            style: defStyle),
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
            style: defStyle),
        InputBox(
            controller: password,
            label: "Password",
            textInputType: TextInputType.text,
            style: defStyle),
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

  LoginButton({
    Key? key,
    required this.name,
    required this.pass,
    required this.formKey,
    required this.scaffoldKey,
  }) : super(key: key);

  final bloc = injector<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 32.0, bottom: defaultSpacing),
        child: InkWell(
          onTap: () {
            if (!loginView.value) {
              loginView.value = !loginView.value;
            }
            if (formKey.currentState!.validate()) {
              Map info = {
                "password": pass.text.toString(),
                "userName": name.text.toString()
              };
              bloc.login(json.encode(info), context);
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
                child: BlocBuilder<LoginCubit, LoginState>(
              bloc: bloc,
              builder: (context, state) {
                if (state == const LoginState.loginLoading()) {
                  return const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                } else {
                  return const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  );
                }
              },
            )),
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

  RegisterButton({
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

  final bloc = injector<RegisterCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: defaultSpacing),
        child: InkWell(
          onTap: () {
            if (loginView.value) {
              loginView.value = !loginView.value;
            }
            if (formKey.currentState!.validate()) {
              Map info = {
                "emailAddress": email,
                "lastname": lastname,
                "password": password,
                "surname": surname,
                "username": username,
                "institution": institution
              };
              bloc.register(json.encode(info));
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
                child: BlocBuilder<RegisterCubit, RegisterState>(
              bloc: bloc,
              builder: (context, state) {
                if (state == const RegisterState.registerLoading()) {
                  return const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                } else {
                  return const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  );
                }
              },
            )
                ),
          ),
        ));
  }
}
