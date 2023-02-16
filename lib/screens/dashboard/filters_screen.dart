import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/filters.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/Frame_custom_dialog.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
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
          child: FiltersWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class FiltersWidget extends StatefulWidget {
  FiltersWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  late final myProvider;

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();
  TextEditingController NameController = TextEditingController();

  void addResult(FiltersModel data) async {
    try {
      var formData = {
        "id": "0",
        "name": "${NameController.text}",
      };
      await myProvider
          .addNew(context, Filters, json.encode(formData))
          .then((value) {
        myProvider.getAll(context, myProvider.getFiltersList, Filters);
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
    myProvider.getAll(context, myProvider.getFiltersList, Filters);
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
                        Filters,
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
                      valueListenable: myProvider.getFiltersList,
                      builder: (context, value, child) {
                        return RecentFiles(
                          title: "Recent Filters",
                          tableHeight:
                              MediaQuery.of(context).size.height * 0.75,
                          scaffoldKey: widget.scaffoldKey,
                          progressController: progressController,
                          list: myProvider.getFiltersList.value,
                          dataRowList: FrameDataRow(
                              myProvider.getFiltersList.value.length,
                              myProvider.getFiltersList.value,
                              context,
                              onPressedDeleteButton,
                              onPressedEditButton),
                          dataColumnList: FiltersDataTable(),
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
          return CustomDialog(
              formKey: _formKey,
              scaffoldKey: widget.scaffoldKey,
              c: context,
              f: (value) {
                var d = FiltersModel(
                  id: data.id,
                  name: NameController.text,
                );
                EditResult(d);
              },
              progressController: progressController,
              btnTitle: "Edit",
              data: data,
              customWidget: FrameCustomDialog(
                NameController: NameController,
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

  void EditResult(FiltersModel data) async {
    try {
      var formData = {
        "id": data.id,
        "name": "${data.name}",
      };
      await myProvider
          .updateData(context, Filters, data, json.encode(formData))
          .then((value) {
        myProvider.getAll(context, myProvider.getFiltersList, Filters);
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

  void DeleteResult(FiltersModel data) async {
    CustomAlertDialog.alertstateSetter!(
      () => progressController.setValue(true),
    );
    try {
      await myProvider.deleteData(context, Filters, data.id).then((value) {
        myProvider.getAll(context, myProvider.getFiltersList, Filters);
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
          return CustomDialog(
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: FiltersModel(
                id: 0,
                name: "",
              ),
              customWidget: FrameCustomDialog(
                NameController: NameController,
              ));
        });
  }
}
