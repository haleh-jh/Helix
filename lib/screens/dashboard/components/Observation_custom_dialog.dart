import 'package:admin/controllers/DataController.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ObservationCustomDialog extends StatelessWidget {
//  final TextEditingController userNameController;
//  final TextEditingController lastNameController;
//  final TextEditingController surnameController;
//  final TextEditingController emailController;
//  final TextEditingController phoneController;
  final BuildContext c;
  final DataController provider;
  const ObservationCustomDialog({
    Key? key,
    required this.c,
    required this.provider,
    //  required this.userNameController,
    //   required this.lastNameController,
    //  required this.surnameController,
    //  required this.emailController,
    //  required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //  StarageDetails(c: context,)
      ],
    );
  }
}
