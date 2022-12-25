import 'dart:convert';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/cards_widget.dart';
import 'package:admin/screens/dashboard/components/detector_drop_down.dart';
import 'package:admin/screens/dashboard/components/frame_drop_down.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  ValueNotifier<GeneralModel?> telescopeValue = ValueNotifier(null);
  ValueNotifier<GeneralModel?> detectorValue = ValueNotifier(null);
  ValueNotifier<GeneralModel?> objectValue = ValueNotifier(null);
  ValueNotifier<GeneralModel?> frameValue = ValueNotifier(null);

  @override
  State<ObservationsWidget> createState() => _ObservationsWidgetState();
}

class _ObservationsWidgetState extends State<ObservationsWidget> {
  late final myProvider;
  String Observations = "Observations";

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();

  void addResult(ObservationsModel data) async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      String formattedDate = formatter.format(now);

      var userId = PreferenceUtils.getString('id');
      var formData = {
        "id": "0",
        "dateTime": "${formattedDate}",
        "frameId": widget.frameValue.value!.key,
        "sObjectId": widget.objectValue.value!.key,
        "telescopeId": widget.telescopeValue.value!.key,
        "detectorId": widget.detectorValue.value!.key,
        "userId": userId
      };

      await myProvider
          .addNew(ObservationsPath, jsonEncode(formData))
          .then((value) {
        myProvider.getAll(
            context, myProvider.getObservationsList, ObservationsPath);
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
                    dataRowList: ObservationDataRow(
                      myProvider.getObservationsList.length,
                      myProvider.getObservationsList,
                      context,
                      onPressedDeleteButton,
                      onPressedEditButton,
                      false
                    ),
                    dataColumnList: ObservationDataTable(),
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
              data: data,
              customWidget: Container());
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
          .updateData(ObservationsPath, data, json.encode(formData))
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
      await myProvider.deleteData(ObservationsPath, data.id).then((value) {
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
          final listDataController =
              Provider.of<DataController>(c, listen: false);
          return ListenableProvider<DataController>.value(
              value: listDataController,
              child: CustomDialog(
                  path: Observations,
                  formKey: _formKey,
                  scaffoldKey: key,
                  c: context,
                  f: addResult,
                  btnTitle: "Add",
                  progressController: progressController,
                  data: ObservationsModel(
                    id: 0,
                    dateTime: '',
                    status: '',
                    detectorName: '',
                    frameName: '',
                    sObject: null,
                    telescopeName: '',
                    userName: '',
                  ),
                  customWidget: CardsWidget(
                    telescopeValue: widget.telescopeValue,
                    detectorValue: widget.detectorValue,
                    frameValue: widget.frameValue,
                    objectValue: widget.objectValue,
                  )));
        });
  }
}




// var formData = FormData();
// for (var file in filepath) {
//   formData.files.addAll([
//   MapEntry("assignment", await MultipartFile.fromFile(file)),
// ]);
// }


// https://stackoverflow.com/questions/59761947/choose-a-file-and-send-through-post-with-flutter-web
