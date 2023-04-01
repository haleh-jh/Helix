
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/input_box.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String svgSrc;
  final IconData? iconData;
  final Color iconColor;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.svgSrc: '',
    this.iconData,
    this.iconColor: Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: svgSrc.isNotEmpty
                ? SvgPicture.asset(svgSrc)
                : Icon(
                    iconData,
                    color: iconColor,
                  ),
          ),
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: InputBox(
                    controller: controller,
                    label: hint,
                    textInputType: TextInputType.text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis),
                  ))),
        ],
      ),
    );
  }
}

enum typeObject { Telescope, Detector, Object, Frame }
