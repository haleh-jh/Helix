import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservationsScreen extends StatelessWidget {
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
          child: ObservationsWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class ObservationsWidget extends StatefulWidget {
  ObservationsWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<ObservationsWidget> createState() => _ObservationsWidgetState();
}

class _ObservationsWidgetState extends State<ObservationsWidget> {
  late final myProvider;
  String Observations = "Observations";
  String ObservationsPath = "ObservationSubmissions";

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();

  void addResult(ObservationsModel data) async {
    try {
      var formData = {
        "id": "0",
        // "name": "${data.name}",
        // "type": "${data.type}",
        // "filter": "${data.filter}",
      };
      await myProvider
          .addNew(ObservationsPath, json.encode(formData))
          .then((value) {
        print("vv: $value");
        var res = ObservationsModel.fromJson(value);
        myProvider.addData(res, myProvider.getObservationsList);
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

    myProvider.getAll(
        context, myProvider.getObservationsList, ObservationsPath);
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
                        Observations,
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
                    title: "Recent Observations",
                    scaffoldKey: widget.scaffoldKey,
                    progressController: progressController,
                    list: myProvider.getObservationsList,
                    dataRowList: TelescopeDataRow(
                        myProvider.getObservationsList.length,
                        myProvider.getObservationsList,
                        context,
                        onPressedDeleteButton,
                        onPressedEditButton,
                        ),
                    dataColumnList: TelescopDataTable(),
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
              path: Observations,
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
              path: Observations,
              c: context,
              deleteFunction: DeleteResult,
              progressController: progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  void EditResult(ObservationsModel data) async {
    try {
      var formData = {
        "id": data.id,
        // "name": "${data.name}",
        // "type": "${data.type}",
        // "filter": "${data.filter}",
      };
      await myProvider
          .updateData(Observations, data, json.encode(formData))
          .then((value) {
        print("ss: ${value.toString()}");
        myProvider.updateList(value, myProvider.getObservationsList);
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

  void DeleteResult(ObservationsModel data) async {
    CustomAlertDialog.alertstateSetter!(
      () => progressController.setValue(true),
    );
    try {
      await myProvider.deleteData(Observations, data.id).then((value) {
        myProvider.deleteList(data, myProvider.getObservationsList);
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
          return Container();
          //  CustomDialog(
          //     path: Observations,
          //     formKey: _formKey,
          //     scaffoldKey: key,
          //     c: context,
          //     f: addResult,
          //     btnTitle: "Add",
          //     progressController: progressController,
          //     data: ObservationsModel(
          //       id: 0,
          //       name: "",
          //       type: "",
          //       filter: "",
          //     ));
        });
  }
}
