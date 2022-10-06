import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar customErrorSnackbar(String text, BuildContext context) {
    return SnackBar(
      backgroundColor: kOrangeColor,
      content: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Icon(
            Icons.error,
            color: Colors.white,
          ),
          SizedBox(width: 4,),
              Expanded(
                child: Container(
                  child: Text(text, style: Theme.of(context).textTheme.headline6!.copyWith(color: kMainLightColor),),),
              ),
            ],
          )),
      behavior: SnackBarBehavior.floating,
    
    );
  }

  //   static SnackBar customSnackbar(String text, BuildContext context) {
  //   return SnackBar(
  //     backgroundColor: kTxtRecordsPrescription,
  //     content: Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: Container(
  //           child: Text(text, style: Theme.of(context).textTheme.headline6!.copyWith(color: kMainLightColor),),)),
  //     behavior: SnackBarBehavior.floating,
    
  //   );
  // }

  // static SnackBar customSnackbarWithAction(String text, BuildContext context, Function() onTap, String actionTitle) {
  //   return SnackBar(
  //     backgroundColor: kTxtRecordsPrescription,
  //     content: Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: Container(
  //           child: Row(
  //             children: [
  //               Expanded(child: Text(text, style: Theme.of(context).textTheme.headline6!.copyWith(color: kMainLightColor),)),
  //               SizedBox(width: 2.sp,),
  //               GestureDetector(
  //                   onTap: onTap,
  //                   child: Text(actionTitle, style: Theme.of(context).textTheme.headline6!.copyWith(color: kMainLightColor),)),
  //             ],
  //           ),)),
  //     behavior: SnackBarBehavior.floating,

  //   );
  // }

}

