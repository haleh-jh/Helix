import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

  typedef DeleteCallbackF<T> = void Function(T value);

class CustomAlertDialog<T> extends StatelessWidget {
  CustomAlertDialog({
    Key? key,
    required this.c,
    this.deleteFunction,
    required this.title,
    required this.data,
    this.progressController,
    
  }) : super(key: key);

  final BuildContext c;
  final String title;
  var progressController;
  final DeleteCallbackF<T>? deleteFunction;
  var data;

  static StateSetter? alertstateSetter;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (cc, state) {
      alertstateSetter = state;
      return 
    AlertDialog(
            backgroundColor: secondaryColor,
            title: Text(title, style: Theme.of(context).textTheme.button,),
            actions: [
              ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                child: Text('No', style: Theme.of(context).textTheme.button,),
              ),
                ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical:
                        defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                  ),
                ),
                onPressed: () => deleteFunction!(data as T),
                child: progressController.listenableValue
                          ? SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              )): Text('Yes', style: Theme.of(context).textTheme.button,),
              ),
            ],
          );
         });
  }

}
