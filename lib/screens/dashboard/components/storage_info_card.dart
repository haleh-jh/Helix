import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/screens/dashboard/components/detector_drop_down.dart';
import 'package:admin/screens/dashboard/components/frame_drop_down.dart';
import 'package:admin/screens/dashboard/components/object_drop_down.dart';
import 'package:admin/screens/dashboard/components/telescope_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class StorageInfoCard extends StatelessWidget {
  final Function() onTap;
  final ValueNotifier<GeneralModel?> telescopeValue;
  final ValueNotifier<GeneralModel?> detectorValue ;
  final ValueNotifier<GeneralModel?> objectValue;
  final ValueNotifier<GeneralModel?> frameValue;


  const StorageInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.onTap, required this.telescopeValue, required this.detectorValue, required this.objectValue, required this.frameValue,
  }) : super(key: key);

  final String title, svgSrc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
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
                      child: TelescopeDropDown(title: title, telescopeValue: telescopeValue),
                    ),
                  } else if (title.contains(typeObject.Detector.name)) ...{
                    InkWell(
                      onTap: onTap,
                      child: DetectorDropDown(title: title, detectorValue: detectorValue,),
                    ),
                  } else if (title.contains(typeObject.Object.name)) ...{
                    InkWell(
                      onTap: onTap,
                      child: ObjectDropDown(title: title, objectValue: objectValue,),
                    ),
                  } else if (title.contains(typeObject.Frame.name)) ...{
                    InkWell(
                      onTap: onTap,
                      child: FrameDropDown(title: title, frameValue: frameValue,),
                    ),
                  }
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

enum typeObject { Telescope, Detector, Object, Frame }
