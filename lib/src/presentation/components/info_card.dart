import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/telescope_drop_down.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InfoCard extends StatelessWidget {
  final Function() onTap;
  final ValueNotifier<DataModel?> telescopeValue;
  final ValueNotifier<DataModel?> detectorValue;
  final ValueNotifier<DataModel?> objectValue;
  final ValueNotifier<DataModel?> frameValue;

  InfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.onTap,
    required this.telescopeValue,
    required this.detectorValue,
    required this.objectValue,
    required this.frameValue,
  }) : super(key: key);

  final String title, svgSrc;

  final bloc = injector<DashboardBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(svgSrc),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.contains(typeObject.Telescope.name)) ...{
                    InkWell(
                      onTap: onTap,
                      child: TelescopeDropDown(
                          title: title,
                          valueNotifier: telescopeValue,
                          list: bloc.TelescopeDropDownList,),
                    ),
                  }
                  // else if (title.contains(typeObject.Detector.name)) ...{
                  //   InkWell(
                  //     onTap: onTap,
                  //     child: DetectorDropDown(
                  //       title: title,
                  //       detectorValue: detectorValue,
                  //     ),
                  //   ),
                  // } else if (title.contains(typeObject.Object.name)) ...{
                  //   InkWell(
                  //     onTap: onTap,
                  //     child: ObjectDropDown(
                  //       title: title,
                  //       objectValue: objectValue,
                  //     ),
                  //   ),
                  // } else if (title.contains(typeObject.Filter.name)) ...{
                  //   InkWell(
                  //     onTap: onTap,
                  //     child: FrameDropDown(
                  //       title: title,
                  //       frameValue: frameValue,
                  //     ),
                  //   ),
                  // }
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum typeObject { Telescope, Detector, Object, Filter }
