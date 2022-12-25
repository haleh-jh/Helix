import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/Frame_custom_dialog.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FramesScreen extends StatelessWidget {
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
          child: FramesWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class FramesWidget extends StatefulWidget {
  FramesWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<FramesWidget> createState() => _FramesWidgetState();
}

class _FramesWidgetState extends State<FramesWidget> {
  late final myProvider;

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();
  TextEditingController NameController = TextEditingController();
  TextEditingController FrameFilterController = TextEditingController();
  TextEditingController FrameTypeController = TextEditingController();

  void addResult(FramesModel data) async {
    try {
      var formData = {
        "id": "0",
        "name": "${NameController.text}",
        "type": "${FrameTypeController.text}",
        "filter": "${FrameFilterController.text}",
      };
      await myProvider.addNew(Frames, json.encode(formData)).then((value) {
        print("vv: $value");
        var res = FramesModel.fromJson(value);
        myProvider.addData(res, myProvider.getFramesList);
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
                        Frames,
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
                  // RecentFiles(
                  //   title: "Recent $Frames",
                  //   scaffoldKey: widget.scaffoldKey,
                  //   path: Frames,
                  //   editFunction: (value) {
                  //     EditResult(value as FramesModel);
                  //   },
                  //   deleteFunction: (value) {
                  //     DeleteResult(value as FramesModel);
                  //   },
                  //   progressController: progressController,
                  //   list: myProvider.getFramesList,
                  //   isObject: false,
                  // ),
                  RecentFiles(
                    title: "Recent Detectors",
                    scaffoldKey: widget.scaffoldKey,
                    progressController: progressController,
                    list: myProvider.getFramesList,
                    dataRowList: FrameDataRow(
                        myProvider.getFramesList.length,
                        myProvider.getFramesList,
                        context,
                        onPressedDeleteButton,
                        onPressedEditButton),
                    dataColumnList: FramesDataTable(),
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
          FrameFilterController.text = data.filter;
          FrameTypeController.text = data.type;
          return CustomDialog(
              path: Frames,
              formKey: _formKey,
              scaffoldKey: widget.scaffoldKey,
              c: context,
              f: (value) {
                var d = FramesModel(
                  id: data.id,
                  name: NameController.text,
                  type: FrameTypeController.text,
                  filter: FrameFilterController.text,
                );
                EditResult(d);
              },
              progressController: progressController,
              btnTitle: "Edit",
              data: data,
              customWidget: FrameCustomDialog(
                FrameFilterController: FrameFilterController,
                FrameTypeController: FrameTypeController,
                NameController: NameController,
              ));
        });
  }

  onPressedDeleteButton(BuildContext c, var data) async {
    await showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              path: Frames,
              c: context,
              deleteFunction: DeleteResult,
              progressController: progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  void EditResult(FramesModel data) async {
    try {
      var formData = {
        "id": data.id,
        "name": "${data.name}",
        "type": "${data.type}",
        "filter": "${data.filter}",
      };
      await myProvider
          .updateData(Frames, data, json.encode(formData))
          .then((value) {
        print("ss: ${value.toString()}");
        myProvider.updateList(value, myProvider.getFramesList);
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

  void DeleteResult(FramesModel data) async {
    CustomAlertDialog.alertstateSetter!(
      () => progressController.setValue(true),
    );
    try {
      await myProvider.deleteData(Frames, data.id).then((value) {
        myProvider.deleteList(data, myProvider.getFramesList);
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
          FrameFilterController.text = "";
          FrameTypeController.text = "";
          return CustomDialog(
              path: Frames,
              formKey: _formKey,
              scaffoldKey: key,
              c: context,
              f: addResult,
              btnTitle: "Add",
              progressController: progressController,
              data: FramesModel(
                id: 0,
                name: "",
                type: "",
                filter: "",
              ),
              customWidget: FrameCustomDialog(
                FrameFilterController: FrameFilterController,
                FrameTypeController: FrameTypeController,
                NameController: NameController,
              ));
        });
  }
}
