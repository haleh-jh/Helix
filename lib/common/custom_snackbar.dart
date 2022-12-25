import 'package:admin/common/custom_button.dart';
import 'package:admin/common/date_picker/linear_date_picker.dart';
import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sizer/sizer.dart';

class CustomSnackbar {
  static SnackBar customErrorSnackbar(String text, BuildContext context) {
    return SnackBar(
      backgroundColor: kOrangeColor,
      content: Row(
        children: [
          Icon(
        Icons.error,
        color: Colors.white,
      ),
      SizedBox(width: 4,),
          Expanded(
            child: Container(
              child: Text(text, style: Theme.of(context).textTheme.headline6!.copyWith(color: kMainLightColor), ),),
          ),
        ],
      ),
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

class CustomDatePicker{

static customDatePicker(BuildContext context, Function callBack, String startDate, String endDate) {
    String date ="";


//     Jalali picked = await showPersianDatePicker(
//     context: context,
//     initialDate: Jalali.now(),
//     firstDate: Jalali(1385, 8),
//     lastDate: Jalali(1450, 9),
// );
// var label = picked.formatFullDate();

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(6.w, 2.w, 6.w, 2.w),
                          decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8.w),
                        topLeft: Radius.circular(8.w))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Custombutton(
                            title: "لغو",
                            btnRadius: 4.w,
                            horizontal: 8.w,
                            vertical: 0.5.h,
                            txtSize: 0.8,
                            bgColor: kCustomElevatedButtonColor,
                            titleColor: kMainLightColor,
                            press: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Custombutton(
                            title: "تایید",
                            btnRadius: 4.w,
                            horizontal: 8.w,
                            vertical: 0.5.h,
                            bgColor: kCustomElevatedButtonColor,
                            txtSize: 0.8,
                            titleColor: kMainLightColor,
                            press: () {
                              callBack(date);
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    Expanded(
                        child: LinearDatePicker(
                      startDate: startDate,
                      endDate: endDate,
                      initialDate: DateTime.now().toPersianDate().toEnglishDigit(),
                      dateChangeListener: (String selectedDate) {
                        date = selectedDate;
                      },
                      showDay: true,
                      labelStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                      selectedRowStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.deepOrange,
                      ),
                      unselectedRowStyle: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                      yearText: "year",
                      monthText: "month",
                      dayText: "day",
                      showLabels: true,
                      columnWidth: 25.w,
                      showMonthName: true,
                      isJalaali: true,
                    ))
                  ],
                ));
          });
        });

  }



}