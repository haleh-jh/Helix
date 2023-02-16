import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/object_custom_dialog.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObjectsScreen extends StatelessWidget {
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
          child: ObjectsWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class ObjectsWidget extends StatefulWidget {
  ObjectsWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<ObjectsWidget> createState() => _ObjectsWidgetState();
}

class _ObjectsWidgetState extends State<ObjectsWidget> {
  late final myProvider;
  String ObjectsTitle = "Objects";

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();
  TextEditingController NameController = TextEditingController();
  TextEditingController decController = TextEditingController();
  TextEditingController raController = TextEditingController();

  void addResult(SObjects data) async {
    try {
      var formData = {
        "id": "0",
        "name": "${NameController.text}",
        "ra": "${raController.text}",
        "dec": "${decController.text}",
      };
      await myProvider
          .addNew(context, Objects, json.encode(formData))
          .then((value) {
        myProvider.getAll(context, myProvider.getSObjectsList, Objects);
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
    super.initState();
    myProvider = Provider.of<DataController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    DataController.ProgressNotifier = ValueNotifier(true);
    myProvider.getAll(context, myProvider.getSObjectsList, Objects);
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
                        ObjectsTitle,
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
                  ValueListenableBuilder(
                      valueListenable: myProvider.getSObjectsList,
                      builder: (context, value, child) {
                        return RecentFiles(
                          title: "Recent Objectss",
                          tableHeight:
                              MediaQuery.of(context).size.height * 0.75,
                          scaffoldKey: widget.scaffoldKey,
                          progressController: progressController,
                          list: myProvider.getSObjectsList.value,
                          dataRowList: SObjectDataRow(
                            myProvider.getSObjectsList.value.length,
                            myProvider.getSObjectsList.value,
                            context,
                            onPressedDeleteButton,
                            onPressedEditButton,
                          ),
                          dataColumnList: SObjectsDataTable(),
                        );
                      })
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
          NameController.text = data.name;
          decController.text = data.dec;
          raController.text = data.ra;
          return CustomDialog(
              formKey: _formKey,
              scaffoldKey: widget.scaffoldKey,
              c: context,
              f: (value) {
                var d = SObjects(
                    id: data.id,
                    name: NameController.text,
                    ra: raController.text,
                    dec: decController.text);
                EditResult(d);
              },
              progressController: progressController,
              btnTitle: "Edit",
              data: data,
              customWidget: ObjectCustomDialog(
                NameController: NameController,
                decController: decController,
                raController: raController,
              ));
        });
  }

  onPressedDeleteButton(BuildContext c, var data) async {
    await showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              c: context,
              deleteFunction: DeleteResult,
              progressController: progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  void EditResult(SObjects data) async {
    try {
      var formData = {
        "id": "${data.id}",
        "name": "${data.name}",
        "ra": "${data.ra}",
        "dec": "${data.dec!}",
      };
      await myProvider
          .updateData(context, Objects, data, json.encode(formData))
          .then((value) {
        myProvider.getAll(context, myProvider.getSObjectsList, Objects);
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

  void DeleteResult(SObjects data) async {
    CustomAlertDialog.alertstateSetter!(
      () => progressController.setValue(true),
    );
    try {
      await myProvider.deleteData(context, Objects, data.id).then((value) {
        myProvider.getAll(context, myProvider.getSObjectsList, Objects);
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
          NameController.text = "";
          decController.text = "";
          raController.text = "";
          return CustomDialog(
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: SObjects(id: 0, name: "", ra: "", dec: ""),
              customWidget: ObjectCustomDialog(
                NameController: NameController,
                decController: decController,
                raController: raController,
              ));
        });
  }
}
