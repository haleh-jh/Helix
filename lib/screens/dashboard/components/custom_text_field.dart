import 'package:admin/common/custom_text_field.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/screens/dashboard/components/detector_drop_down.dart';
import 'package:admin/screens/dashboard/components/frame_drop_down.dart';
import 'package:admin/screens/dashboard/components/object_drop_down.dart';
import 'package:admin/screens/dashboard/components/telescope_drop_down.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String svgSrc;
  final IconData? iconData;
  final Color iconColor;
  final TextEditingController controller;


  const CustomTextField({
    Key? key, required this.controller, required this.hint, this.svgSrc : '', this.iconData, this.iconColor : Colors.white,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: svgSrc.length>0? SvgPicture.asset(svgSrc) : Icon(iconData, color: iconColor,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: InputBox(controller: controller, label: hint, textInputType: TextInputType.text, style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis),
              
              
              )
          )
          ),
        ],
      ),
    );
  }

}

enum typeObject { Telescope, Detector, Object, Frame }
