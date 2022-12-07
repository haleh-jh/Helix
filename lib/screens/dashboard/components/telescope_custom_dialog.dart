import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TelescopeCustomDialog extends StatelessWidget {
  final TextEditingController NameController;
  final TextEditingController TypeController;
  final String path;
  const TelescopeCustomDialog({
    Key? key,
    required this.NameController,
    required this.TypeController,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        InputBox(
          controller: TypeController,
          label: "${path} Type",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
