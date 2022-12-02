import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/coordinate.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
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
  String Objects = "SObjects";
  String ObjectsTitle = "Objects";

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();

  void addResult(SObjects data) async {
    try {
      var formData = {
        "id": "0",
        "name": "${data.name}",
        "ra": "${data.coordinate!.ra}",
        "dec": "${data.coordinate!.dec}",
      };
      await myProvider.addNew(Objects, json.encode(formData)).then((value) {
        var res = SObjects.fromJson(value);
        myProvider.addData(res, myProvider.getSObjectsList);
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
                  RecentFiles(
                    title: "Recent Objectss",
                    scaffoldKey: widget.scaffoldKey,
                    progressController: progressController,
                    list: myProvider.getSObjectsList,
                    dataRowList: SObjectDataRow(
                        myProvider.getSObjectsList.length,
                        myProvider.getSObjectsList,
                        context,
                        onPressedDeleteButton,
                        onPressedEditButton,
                        ),
                    dataColumnList: SObjectsDataTable(),
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
          return CustomDialog(
              path: ObjectsTitle,
              formKey: _formKey,
              scaffoldKey: widget.scaffoldKey,
              c: context,
              f: EditResult,
              progressController: progressController,
              btnTitle: "Edit",
              data: data);
        });
  }

  onPressedDeleteButton(BuildContext c, var data) async {
    await showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              path: ObjectsTitle,
              c: context,
              deleteFunction: DeleteResult,
              progressController: progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  void EditResult(SObjects data) async {
    try {
      var coordinate = {
        "id": "${data.coordinate!.id}",
        "ra": "${data.coordinate!.ra}",
        "dec": "${data.coordinate!.dec}",
      };
      var formData = {
        "id": "${data.id}",
        "name": "${data.name}",
        "coordinate": "$coordinate",
      };
      await myProvider
          .updateData(Objects, data, json.encode(formData))
          .then((value) {
        print("ss: ${value.toString()}");
        myProvider.updateList(value, myProvider.getSObjectsList);
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
      await myProvider.deleteData(Objects, data.id).then((value) {
        myProvider.deleteList(data, myProvider.getSObjectsList);
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
              path: Objects,
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: SObjects(
                  id: 0,
                  name: "",
                  coordinate: Coordinate(id: 0, ra: "", dec: "")));
        });
  }
}
