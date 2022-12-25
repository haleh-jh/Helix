import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/telescope_custom_dialog.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

typedef EditCallbackF<T> = void Function(T value);

class CustomDialog<T> extends StatelessWidget {
  CustomDialog({
    Key? key,
    required this.formKey,
    required this.scaffoldKey,
    required this.c,
    this.f,
    required this.btnTitle,
    required this.data,
    this.progressController,
    required this.path,
    required this.customWidget,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController NameController = TextEditingController();
  TextEditingController TypeController = TextEditingController();
  TextEditingController raController = TextEditingController();
  TextEditingController decController = TextEditingController();
  TextEditingController FrameTypeController = TextEditingController();
  TextEditingController FrameFilterController = TextEditingController();
  final Widget customWidget;
  final BuildContext c;
  final String btnTitle;
  var progressController;
  final EditCallbackF<T>? f;
  //final Function(Data data)? f;
  var data;
  final String path;

  static StateSetter? stateSetter;

  @override
  Widget build(BuildContext context) {
    if (data is Data) {
      TypeController.text = data.type;
      NameController.text = data.name;
    } else if (data is SObjects) {
      NameController.text = data.name;
      raController.text = data.ra;
      decController.text = data.dec;
    } else if (data is FramesModel) {
      NameController.text = data.name;
      FrameTypeController.text = data.type;
      FrameFilterController.text = data.filter;
    }

    return StatefulBuilder(builder: (cc, state) {
      stateSetter = state;
      return Dialog(
          insetPadding: EdgeInsets.fromLTRB(30.w, 15.h, 30.w, 15.h),
          backgroundColor: secondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
          child: Container(
              width: 100.w,
              padding: EdgeInsets.all(2.w),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customWidget,
                    Expanded(child: Container()),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 2,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          stateSetter!(
                            () => progressController.setValue(true),
                          );
                          Future.delayed(Duration(milliseconds: 2000))
                              .then((value) {
                            var d;
                            if (data is Data) {
                              d = Data(
                                  id: data.id,
                                  name: NameController.text,
                                  type: TypeController.text);
                            } else if (data is SObjects) {
                              d = SObjects(
                                  id: data.id,
                                  name: NameController.text,
                                  ra: raController.text,
                                      dec: decController.text);
                            } else if (data is FramesModel) {
                              d = FramesModel(
                                id: data.id,
                                name: NameController.text,
                                type: FrameTypeController.text,
                                filter: FrameFilterController.text,
                              );
                            } else{
                               d = ObservationsModel(
                                id: data.id, dateTime: '', status: '', detectorName: '', frameName: '', sObject: null, telescopeName: '', userName: '',
                                
                              );
                            }
                            f!(d as T);
                          });
                        }
                      },
                      child: progressController.listenableValue
                          ? SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Text(btnTitle),
                    )
                  ],
                ),
              )));
    });
  }
}
