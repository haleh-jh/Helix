import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/coordinate.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
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
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController NameController = TextEditingController();
  TextEditingController TypeController = TextEditingController();
  TextEditingController raController = TextEditingController();
  TextEditingController decController = TextEditingController();
  TextEditingController FrameTypeController = TextEditingController();
  TextEditingController FrameFilterController = TextEditingController();
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
    NameController.text = data.name;
    if (data is Data) {
      TypeController.text = data.type;
    } else if (data is SObjects) {
      raController.text = data.coordinate.ra;
      decController.text = data.coordinate.dec;
    } else if (data is FramesModel) {
      FrameTypeController.text = data.type;
      FrameFilterController.text = data.filter;
    }

    return StatefulBuilder(builder: (cc, state) {
      stateSetter = state;
      return Dialog(
          insetPadding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 25.h),
          backgroundColor: secondaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
          child: Container(
              width: 100.w,
              padding: EdgeInsets.all(2.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    InputBox(
                      controller: NameController,
                      label: "${path} Name",
                      textInputType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 2.5.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    if (data is SObjects)
                      Column(
                        children: [
                          InputBox(
                            controller: raController,
                            label: "coordinate ra",
                            textInputType: TextInputType.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.5.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          InputBox(
                            controller: decController,
                            label: "coordinate dec",
                            textInputType: TextInputType.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.5.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    if (data is Data)
                      InputBox(
                        controller: TypeController,
                        label: "${path} Type",
                        textInputType: TextInputType.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 2.5.sp,
                            fontWeight: FontWeight.w400),
                      ),
                     if (data is FramesModel)
                      Column(
                        children: [
                          InputBox(
                            controller: FrameTypeController,
                            label: "Frame type",
                            textInputType: TextInputType.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.5.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          InputBox(
                            controller: FrameFilterController,
                            label: "Frame filter",
                            textInputType: TextInputType.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.5.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    
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
                                  coordinate: Coordinate(
                                      id: data.coordinate.id,
                                      ra: raController.text,
                                      dec: decController.text));
                            }
                            else if (data is FramesModel) {
                              d = FramesModel(
                                  id: data.id,
                                  name: NameController.text,
                                  type: FrameTypeController.text,
                                  filter: FrameFilterController.text,
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
