import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FrameCustomDialog extends StatelessWidget {
  final TextEditingController NameController;
  final TextEditingController FrameTypeController;
  final TextEditingController FrameFilterController;
  const FrameCustomDialog({
    Key? key,
    required this.NameController,
    required this.FrameTypeController,
    required this.FrameFilterController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          controller: NameController,
          label: "Frame Name",
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
      ],
    );
  }
}
