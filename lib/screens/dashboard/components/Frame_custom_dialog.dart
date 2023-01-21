import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FrameCustomDialog extends StatelessWidget {
  final TextEditingController NameController;
  const FrameCustomDialog({
    Key? key,
    required this.NameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          controller: NameController,
          label: "Filter Name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
