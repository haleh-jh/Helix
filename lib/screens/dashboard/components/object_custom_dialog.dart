import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ObjectCustomDialog extends StatelessWidget {
  final TextEditingController NameController;
  final TextEditingController raController;
  final TextEditingController decController;
  const ObjectCustomDialog({
    Key? key,
    required this.NameController,
    required this.raController,
    required this.decController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          controller: NameController,
          label: "Object Name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 1.h,
        ),
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
      ],
    );
  }
}
