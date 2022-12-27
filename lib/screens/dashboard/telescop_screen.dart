import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ProgressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/dashboard/components/telescope_custom_dialog.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/header.dart';
import 'components/recent_files.dart';
import 'package:provider/provider.dart';

class TelescopScreen extends StatelessWidget {
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
          child: TelescopWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class TelescopWidget extends StatefulWidget {
  TelescopWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<TelescopWidget> createState() => _TelescopWidgetState();
}

class _TelescopWidgetState extends State<TelescopWidget> {
  late final myProvider;
  TextEditingController NameController = TextEditingController();
  TextEditingController TypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();

  void addResult(Data data) async {
    try {
      var formData = json.encode({
        "id": "0",
        "name": "${NameController.text}",
        "type": "${TypeController.text}",
      });
      await myProvider.addNew(telescope, formData).then((value) {
        var res = Data.fromJson(value);
        myProvider.addData(res, myProvider.getTelescopeList);
      });
      Navigator.of(context, rootNavigator: true).pop();
      CustomDialog.stateSetter!(
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

  @override
  void initState() {
    myProvider = Provider.of<DataController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataController.ProgressNotifier = ValueNotifier(true);
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
                        telescope,
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
                    title: "Recent $telescope",
                    scaffoldKey: widget.scaffoldKey,
                    progressController: progressController,
                    list: myProvider.getTelescopeList,
                    dataColumnList: TelescopDataTable(),
                    dataRowList: TelescopeDataRow(
                        myProvider.getTelescopeList.length,
                        myProvider.getTelescopeList,
                        context,
                        onPressedDeleteButton,
                        onPressedEditButton),
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
          NameController.text = data.name;
          TypeController.text = data.type;
          return CustomDialog(
            path: telescope,
            formKey: _formKey,
            scaffoldKey: widget.scaffoldKey,
            c: context,
            f: (value) {
              var d = Data(
                  id: data.id,
                  name: NameController.text,
                  type: TypeController.text);
              EditResult(d);
            },
            progressController: progressController,
            btnTitle: "Edit",
            data: data,
            customWidget: TelescopeCustomDialog(
                NameController: NameController,
                TypeController: TypeController,
                path: telescope),
          );
        });
  }

  onPressedDeleteButton(BuildContext c, var data) async {
    await showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              path: telescope,
              c: context,
              deleteFunction: DeleteResult,
              progressController: progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  void EditResult(Data data) async {
    try {
      var formData = json.encode({
        "id": data.id,
        "name": NameController.text,
        "type": TypeController.text
      });
      await myProvider.updateData(telescope, data, formData).then((value) {
        myProvider.updateList(value, myProvider.getTelescopeList);
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

  void DeleteResult(Data data) async {
    CustomAlertDialog.alertstateSetter!(
      () => progressController.setValue(true),
    );
    try {
      await myProvider.deleteData(telescope, data.id).then((value) {
        myProvider.deleteList(data, myProvider.getTelescopeList);
      });
      Navigator.of(context, rootNavigator: true).pop();
      CustomAlertDialog.alertstateSetter!(
        () => progressController.setValue(false),
      );
    } catch (e) {
      CustomAlertDialog.alertstateSetter!(
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
          TypeController.text = "";
          return CustomDialog(
              path: telescope,
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: Data(id: 0, name: "", type: ""),
              customWidget: TelescopeCustomDialog(
                  NameController: NameController,
                  TypeController: TypeController,
                  path: telescope));
        });
  }
}
