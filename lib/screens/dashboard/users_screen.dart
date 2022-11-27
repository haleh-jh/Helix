import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var providerType = Provider.of<DataController>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: UsersWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class UsersWidget extends StatefulWidget {
  UsersWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<UsersWidget> createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  late final myProvider;
  String Users = "Users";

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();

  void addResult(User data) async {
    try {
      var formData = {
        "id": "0",
        "name": "${data.userName}",
        "type": "${data.type}",
      };
      await myProvider.addNew(Users, json.encode(formData)).then((value) {
        print("vv: $value");
        var res = User.fromJson(value);
        myProvider.addData(res, myProvider.getUsersList);
      });
      Navigator.of(context, rootNavigator: true).pop();
      CustomDialog.stateSetter!(
        () => progressController.setValue(false),
      );
    } catch (e) {
      print("e2: ${e.toString()}");
      CustomDialog.stateSetter!(
        () => progressController.setValue(false),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.customErrorSnackbar(e.toString(), context));
    }
  }

  @override
  void initState() {
    myProvider = Provider.of<DataController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataController.ProgressNotifier = ValueNotifier(false);

    myProvider.getAll(context, myProvider.getUsersList, Users);
    return Column(
      children: [
        Header(
          title: Users,
        ),
        SizedBox(height: defaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: defaultPadding /
                                (Responsive.isMobile(context) ? 2 : 1),
                          ),
                        ),
                        onPressed: () {
                          onPressedButton(context, widget.scaffoldKey);
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add New"),
                      ),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  RecentFiles(
                    title: "Recent $Users",
                    scaffoldKey: widget.scaffoldKey,
                    path: Users,
                    editFunction: (value) {
                      EditResult(value as User);
                    },
                    deleteFunction: (value) {
                      DeleteResult(value as User);
                    },
                    progressController: progressController,
                    list: myProvider.getUsersList,
                    isObject: false,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void EditResult(User data) async {
    try {
      var formData = {
        "id": data.id,
        "name": "${data.userName}",
        "type": "${data.type}",
      };
      await myProvider
          .updateData(Users, data, json.encode(formData))
          .then((value) {
        print("ss: ${value.toString()}");
        myProvider.updateList(value, myProvider.getUsersList);
        CustomDialog.stateSetter!(
          () => progressController.setValue(false),
        );
        Navigator.of(context, rootNavigator: true).pop();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.customErrorSnackbar(e.toString(), context));
      CustomDialog.stateSetter!(
        () => progressController.setValue(false),
      );
    }
  }

  void DeleteResult(User data) async {
    CustomAlertDialog.alertstateSetter!(
      () => progressController.setValue(true),
    );
    try {
      await myProvider.deleteData(Users, data.id).then((value) {
        myProvider.deleteList(data, myProvider.getUsersList);
      });
      Navigator.of(context, rootNavigator: true).pop();
      CustomAlertDialog.alertstateSetter!(
        () => progressController.setValue(false),
      );
    } catch (e) {
      CustomDialog.stateSetter!(
        () => progressController.setValue(false),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar.customErrorSnackbar(e.toString(), context));
    }
  }

  onPressedButton(BuildContext c, var key) {
    showDialog(
        context: c,
        builder: (context) {
          return CustomDialog(
              path: Users,
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: User(
                id: "",
                userName: "",
                normalizedUserName: "",
                email: "",
                normalizedEmail: "",
                emailConfirmed: false,
                passwordHash: "",
                securityStamp: "",
                concurrencyStamp: "",
                phoneNumber: "",
                phoneNumberConfirmed: false,
                twoFactorEnabled: false,
                lockoutEnd: "",
                lockoutEnabled: false,
                accessFailedCount: "",
                type: "",
                surname: "",
                lastName: "",
                institution: "",
                dec: "",
              ));
        });
  }
}