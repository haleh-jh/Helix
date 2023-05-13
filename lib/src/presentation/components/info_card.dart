import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/custom_drop_down.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InfoCard extends StatelessWidget {
  final ValueNotifier<DataModel?> telescopeValue;
  final ValueNotifier<DataModel?> detectorValue;
  final ValueNotifier<DataModel?> objectValue;
  final ValueNotifier<DataModel?> frameValue;
  final String title, svgSrc;
  final int index;

  const InfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.telescopeValue,
    required this.detectorValue,
    required this.objectValue,
    required this.frameValue,
    required this.index,
  }) : super(key: key);

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
                  CustomDropDown(
                    title: title,
                    valueNotifier: index == 0
                        ? telescopeValue
                        : index == 1
                            ? detectorValue
                            : index == 2
                                ? objectValue
                                : frameValue,
                    list: index == 0
                        ? context.read<DashboardBloc>().TelescopeDropDownList
                        : index == 1
                            ? context.read<DashboardBloc>().DetectorDropDownList
                            : index == 2
                                ? context
                                    .read<DashboardBloc>()
                                    .ObjectDropDownList
                                : context
                                    .read<DashboardBloc>()
                                    .FrameDropDownList,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
