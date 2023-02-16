import 'dart:convert';
import 'package:admin/screens/dashboard/components/custom_text_field.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:admin/screens/main/components/view_detail_dialog.dart';
import 'package:dio/dio.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
// import 'package:http/http.dart' as http;

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/cards_widget.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

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

  ValueNotifier<bool> importFileProgress = ValueNotifier(false);

  @override
  State<ObservationsWidget> createState() => _ObservationsWidgetState();
}

class _ObservationsWidgetState extends State<ObservationsWidget> {
  late final myProvider;
  String Observations = "Observations";

  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  var progressController = ProgressController();
  ValueNotifier<int> status = ValueNotifier(0);
  List<FilePickerCross> myFiles = [];
  List<FilePickerCross> importFiles = [];
  ValueNotifier<String> fileName = ValueNotifier('');
  TextEditingController NameController = TextEditingController();
  TextEditingController TypeController = TextEditingController();

  @override
  void initState() {
    myProvider = Provider.of<DataController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataController.ProgressNotifier = ValueNotifier(true);
    myProvider.getAll(
        context, myProvider.getObservationsList, ObservationsPath);
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
                      Row(
                        children: [
                          ElevatedButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical: defaultPadding /
                                      (Responsive.isMobile(context) ? 2 : 1),
                                ),
                              ),
                              onPressed: _onImportBtnTapped,
                              child: ValueListenableBuilder(
                                valueListenable: widget.importFileProgress,
                                builder: (context, value, child) {
                                  return widget.importFileProgress.value
                                      ? SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                      : Text("Import file");
                                },
                              )),
                          SizedBox(
                            width: 20,
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
                      )
                    ],
                  ),
                  SizedBox(height: height),
                  ValueListenableBuilder(
                      valueListenable: myProvider.getObservationsList,
                      builder: (context, value, child) {
                        return RecentFiles(
                          title: "Recent Observations",
                          tableHeight:
                              MediaQuery.of(context).size.height * 0.75,
                          scaffoldKey: widget.scaffoldKey,
                          progressController: progressController,
                          list: myProvider.getObservationsList.value,
                          dataRowList: ObservationDataRow(
                              myProvider.getObservationsList.value.length,
                              myProvider.getObservationsList.value,
                              context,
                              onPressedDeleteButton,
                              onPressedEditButton, (fileinfo) {
                            onPressedViewButton(context, fileinfo);
                          }, false),
                          dataColumnList: ObservationDataTable(),
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

  onPressedButton(BuildContext c, var key) {
    showDialog(
        context: c,
        builder: (context) {
          final listDataController =
              Provider.of<DataController>(c, listen: false);

          widget.frameValue.value = null;
          widget.telescopeValue.value = null;
          widget.detectorValue.value = null;
          widget.objectValue.value = null;
          NameController.text = '';
          TypeController.text = '';

          return ListenableProvider<DataController>.value(
              value: listDataController,
              child: CustomDialog(
                formKey: _formKey,
                scaffoldKey: key,
                c: context,
                f: addResult,
                btnTitle: "Add Observation",
                progressController: progressController,
                data: ObservationsModel(
                  id: '',
                  dateTime: '',
                  status: '',
                  detectorName: '',
                  filterName: '',
                  sObject: null,
                  telescopeName: '',
                  userName: '',
                  name: '',
                  type: '',
                ),
                customWidget: Column(
                  children: [
                    ObservationAddView(),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () async {
                        myFiles =
                            await FilePickerCross.importMultipleFromStorage(
                                type: FileTypeCross
                                    .any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
                                fileExtension:
                                    'txt, md' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
                                );
                        for (var element in myFiles) {
                          fileName.value =
                              "${fileName.value} \n ${element.fileName}";
                        }
                      },
                      child: Text("Select file"),
                    ),
                    ValueListenableBuilder(
                        valueListenable: fileName,
                        builder: (context, value, child) {
                          return fileName.value.length > 0
                              ? Column(
                                  children: [
                                    Text(
                                      fileName.value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: defaultPadding,
                                    ),
                                  ],
                                )
                              : Container();
                        }),
                  ],
                ),
              ));
        });
  }

  Column ObservationAddView() {
    return Column(
      children: [
        CardsWidget(
          telescopeValue: widget.telescopeValue,
          detectorValue: widget.detectorValue,
          frameValue: widget.frameValue,
          objectValue: widget.objectValue,
        ),
        SizedBox(
          height: defaultPadding,
        ),
        CustomTextField(
          controller: NameController,
          hint: "Name",
          iconData: Icons.calendar_today,
          iconColor: Color(0xffffa113),
        ),
        SizedBox(
          height: defaultPadding,
        ),
        CustomTextField(
          controller: TypeController,
          hint: "Type",
          iconData: Icons.calendar_today,
          iconColor: Color(0xffffa113),
        ),
        SizedBox(
          height: defaultPadding,
        ),
      ],
    );
  }

  onPressedEditButton(BuildContext c, var data) {
    showDialog(
        context: c,
        builder: (context) {
          final listDataController =
              Provider.of<DataController>(c, listen: false);
          NameController.text = data.name;
          TypeController.text = data.type;

          widget.telescopeValue.value =
              myProvider.getTelescopeDropDownList.firstWhere(
            (element) {
              return element.value == data.telescopeName;
            },
          );

          widget.detectorValue.value =
              myProvider.getDetectorDropDownList.firstWhere(
            (element) {
              return element.value == data.detectorName;
            },
          );

          widget.objectValue.value =
              myProvider.getSObjectDropDownList.firstWhere(
            (element) {
              return element.value == data.sObject.name;
            },
          );

          widget.frameValue.value = myProvider.getFrameDropDownList.firstWhere(
            (element) {
              return element.value == data.filterName;
            },
          );

          data.status.toString().contains('True')
              ? status.value = 1
              : status.value = 0;

          return ListenableProvider<DataController>.value(
            value: listDataController,
            child: CustomDialog(
                formKey: _formKey,
                scaffoldKey: widget.scaffoldKey,
                c: context,
                f: EditResult,
                progressController: progressController,
                btnTitle: "Edit",
                data: data,
                customWidget: Column(
                  children: [
                    ObservationAddView(),
                    Row(
                      children: [
                        SizedBox(
                          width: defaultPadding,
                        ),
                        Text('Status'),
                        SizedBox(
                          width: defaultPadding * 2,
                        ),
                        ValueListenableBuilder(
                            valueListenable: status,
                            builder: (context, value, child) {
                              return Checkbox(
                                checkColor: Colors.white,
                                activeColor: kCustomElevatedButtonColor,
                                value: status.value == 1 ? true : false,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.w)),
                                onChanged: (bool? res) {
                                  if (res!) {
                                    status.value = 1;
                                  } else
                                    status.value = 0;
                                },
                              );
                            })
                      ],
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    // CardsWidget(
                    //   telescopeValue: widget.telescopeValue,
                    //   detectorValue: widget.detectorValue,
                    //   frameValue: widget.frameValue,
                    //   objectValue: widget.objectValue,
                    // ),
                    // SizedBox(
                    //   height: defaultPadding * 2,
                    // ),
                    // Row(
                    //   children: [
                    //     Text('Status'),
                    //     SizedBox(
                    //       width: defaultPadding * 2,
                    //     ),
                    //     ValueListenableBuilder(
                    //         valueListenable: status,
                    //         builder: (context, value, child) {
                    //           return Checkbox(
                    //             checkColor: Colors.white,
                    //             activeColor: kCustomElevatedButtonColor,
                    //             value: status.value == 1 ? true : false,
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(2.w)),
                    //             onChanged: (bool? res) {
                    //               if (res!) {
                    //                 status.value = 1;
                    //               } else
                    //                 status.value = 0;
                    //             },
                    //           );
                    //         })
                    //   ],
                    // ),
                  ],
                )),
          );
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

  void addResult(ObservationsModel data) async {
    try {
      var now = new DateTime.now();
      var formatter = new DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      String formattedDate = formatter.format(now);

      var userId = PreferenceUtils.getString('id');
      var formData = {
        "dateTime": "${formattedDate}",
        "filterId": widget.frameValue.value!.key,
        "sObjectId": widget.objectValue.value!.key,
        "telescopeId": widget.telescopeValue.value!.key,
        "detectorId": widget.detectorValue.value!.key,
        "userId": userId,
        "status": status.value == 1 ? true : false,
        "name": NameController.text,
        "type": TypeController.text,
      };
      await myProvider
          .addNew(context, ObservationsPath, jsonEncode(formData))
          .then((value) async {
        sendFile(value['id'].toString());
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

  void EditResult(ObservationsModel data) async {
    progressController.setValue(false);
    try {
      var userId = PreferenceUtils.getString('id');
      var formData = {
        "id": data.id,
        "dateTime": data.dateTime,
        "filterId": widget.frameValue.value!.key,
        "sObjectId": widget.objectValue.value!.key,
        "telescopeId": widget.telescopeValue.value!.key,
        "detectorId": widget.detectorValue.value!.key,
        "userId": userId,
        "name": NameController.text,
        "type": TypeController.text,
        "status": status.value == 1 ? true : false,
      };
      await myProvider
          .updateData(context, ObservationsPath, data, json.encode(formData))
          .then((value) {
        print("ss: ${value.toString()}");
        myProvider.getAll(
            context, myProvider.getObservationsList, ObservationsPath);
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
      print("delete ${data.id}");
      await myProvider
          .deleteDataV2(context, ObservationsPath, data.id)
          .then((value) {
        myProvider.getAll(
            context, myProvider.getObservationsList, ObservationsPath);
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

  sendFile(String id) async {
    if (myFiles.length > 0) {
      var formData = [];
      for (var file in myFiles) {
        formData.add(http.MultipartFile.fromBytes('files', file.toUint8List(),
            contentType: new MediaType('application', 'octet-stream'),
            filename: file.fileName));
      }
      print(formData.toString());
      await myProvider.uploadData(context, formData, id).then((value) async {
        print("valueeee: $value");
      });
    }
  }

  importFile() async {
    if (importFiles.length > 0) {
      widget.importFileProgress.value = true;
      for (var file in importFiles) {
        final formData = FormData.fromMap({
          'files': MultipartFile.fromBytes(
            file.toUint8List(),
            contentType: new MediaType('application', 'octet-stream'),
            filename: file.fileName,
          )
        });
        print(formData);
        try {
          await myProvider.ImportFiles(context, formData).then((value) async {
            print("valueeee: $value");
            if (value != null) {
              widget.importFileProgress.value = false;
              myProvider.getAll(
                  context, myProvider.getObservationsList, ObservationsPath);
            }
          });
        } catch (e) {
          widget.importFileProgress.value = false;
        }
      }
    }
  }

  void _onImportBtnTapped() async {
    await FilePickerCross.importMultipleFromStorage(
            type: FileTypeCross
                .any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
            fileExtension:
                'txt, md' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
            )
        .then((value) {
      importFiles = value;
      importFile();
    });
  }

  onPressedViewButton(BuildContext c, var data) async {
    final listDataController = Provider.of<DataController>(c, listen: false);
    await showDialog(
        context: context,
        builder: (_) {
          return ListenableProvider<DataController>.value(
              value: listDataController,
              child: ViewDetailDialog(
                c: c,
                observation: data,
                ObservationId: data.id,
              ));
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
