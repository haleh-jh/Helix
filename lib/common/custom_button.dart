import 'package:admin/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class Custombutton extends StatelessWidget{
  final String title;
  Color titleColor;
  Color bgColor;
  final double btnRadius;
  double txtSize;
  double horizontal;
  double vertical;
  Function()? press;

  Custombutton({Key? key,required this.title,
   this.titleColor : kIconColor,
    this.bgColor : kMainLightColor,
    this.txtSize: 0.9,
    required this.btnRadius,
    required this.horizontal,
    required this.vertical,
    this.press,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.button!.apply(color: titleColor, fontSizeFactor: txtSize),),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(btnRadius)
        ),
      ),
    );
  }

}