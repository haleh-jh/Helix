import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/User_custom_dialog.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
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

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void addResult(User data) async {
    try {
      var formData = {
        "id": "0",
        "userName": "${userNameController.text}",
        "normalizedUserName": "${data.normalizedUserName}",
        "email": "${emailController.text}",
        "normalizedEmail": "${data.normalizedEmail}",
        "emailConfirmed": "${data.emailConfirmed}",
        "passwordHash": "${data.passwordHash}",
        "securityStamp": "${data.securityStamp}",
        "concurrencyStamp": "${data.concurrencyStamp}",
        "phoneNumber": "${phoneController.text}",
        "phoneNumberConfirmed": "${data.phoneNumberConfirmed}",
        "twoFactorEnabled": "${data.twoFactorEnabled}",
        "lockoutEnd": "${data.lockoutEnd}",
        "lockoutEnabled": "${data.lockoutEnabled}",
        "accessFailedCount": "${data.accessFailedCount}",
        "type": "${data.type}",
        "surname": "${surnameController.text}",
        "lastName": "${lastNameController.text}",
        "institution": "${data.institution}",
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
    DataController.ProgressNotifier = ValueNotifier(true);
    myProvider.getAll(context, myProvider.getUsersList, Users);
    return Column(
      children: [
        SizedBox(height: defaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Users,
                        style: Theme.of(context).textTheme.headline6,
                      ),
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
                  SizedBox(height: height),
                  RecentFiles(
                    title: "Recent Users",
                    scaffoldKey: widget.scaffoldKey,
                    progressController: progressController,
                    list: myProvider.getUsersList,
                    dataRowList: UserDataRow(
                      myProvider.getUsersList.length,
                      myProvider.getUsersList,
                      context,
                      onPressedDeleteButton,
                      onPressedEditButton,
                    ),
                    dataColumnList: UsersDataTable(),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  onPressedEditButton(BuildContext c, var data) {
    showDialog(
        context: c,
        builder: (context) {
          userNameController.text = data.userName;
          lastNameController.text = data.lastname;
          surnameController.text = data.surname;
          emailController.text = data.email;
          phoneController.text = data.phoneNumber;
          return CustomDialog(
              path: Users,
              formKey: _formKey,
              scaffoldKey: widget.scaffoldKey,
              c: context,
              f: (value) {
                var d = User(
                id: data.id,
                userName: userNameController.text,
                normalizedUserName: "",
                email: emailController.text,
                normalizedEmail: "",
                emailConfirmed: false,
                passwordHash: "",
                securityStamp: "",
                concurrencyStamp: "",
                phoneNumber: phoneController.text,
                phoneNumberConfirmed: false,
                twoFactorEnabled: false,
                lockoutEnd: "",
                lockoutEnabled: false,
                accessFailedCount: "",
                type: "",
                surname: surnameController.text,
                lastName: lastNameController.text,
                institution: "",
                des: "",
              );
                EditResult(d);
              },
              progressController: progressController,
              btnTitle: "Edit",
              data: data,
              customWidget: UserCustomDialog(
                  userNameController: userNameController,
                  lastNameController: lastNameController,
                  surnameController: surnameController,
                  emailController: emailController,
                  phoneController: phoneController));
        });
  }

  onPressedDeleteButton(BuildContext c, var data) async {
    await showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              path: Users,
              c: context,
              deleteFunction: DeleteResult,
              progressController: progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  void EditResult(User data) async {
    try {
      var formData = {
        "id": "${data.id}",
        "userName": "${data.userName}",
        "normalizedUserName": "${data.normalizedUserName}",
        "email": "${data.email}",
        "normalizedEmail": "${data.normalizedEmail}",
        "emailConfirmed": "${data.emailConfirmed}",
        "passwordHash": "${data.passwordHash}",
        "securityStamp": "${data.securityStamp}",
        "concurrencyStamp": "${data.concurrencyStamp}",
        "phoneNumber": "${data.phoneNumber}",
        "phoneNumberConfirmed": "${data.phoneNumberConfirmed}",
        "twoFactorEnabled": "${data.twoFactorEnabled}",
        "lockoutEnd": "${data.lockoutEnd}",
        "lockoutEnabled": "${data.lockoutEnabled}",
        "accessFailedCount": "${data.accessFailedCount}",
        "type": "${data.type}",
        "surname": "${data.surname}",
        "lastName": "${data.lastName}",
        "institution": "${data.institution}",
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
          userNameController.text = "";
          lastNameController.text = "";
          surnameController.text = "";
          emailController.text = "";
          phoneController.text = "";
          return CustomDialog(
              path: Users,
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: User(
                id: "0",
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
                des: "",
              ),
              customWidget: UserCustomDialog(
                  userNameController: userNameController,
                  lastNameController: lastNameController,
                  surnameController: surnameController,
                  emailController: emailController,
                  phoneController: phoneController));
        });
  }
}
