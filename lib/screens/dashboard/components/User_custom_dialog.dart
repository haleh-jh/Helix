import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserCustomDialog extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController lastNameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  const UserCustomDialog({
    Key? key,
    required this.userNameController,
    required this.lastNameController,
    required this.surnameController,
    required this.emailController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          controller: userNameController,
          label: "User Name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: lastNameController,
          label: "Last name",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: surnameController,
          label: "Surname",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: emailController,
          label: "Email",
          textInputType: TextInputType.text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 2.5.sp,
              fontWeight: FontWeight.w400),
        ),
        InputBox(
          controller: phoneController,
          label: "Phone",
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
