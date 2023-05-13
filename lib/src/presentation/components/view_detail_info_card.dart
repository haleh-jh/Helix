
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/card_info.dart';

class ViewDetailInfoCard extends StatelessWidget {
  final ObservationsModel observation;
  final int index;
  ViewDetailInfoCard({
    Key? key,
    required this.info,
    required this.observation,
    required this.index,
  }) : super(key: key);

  final TotalInfo info;
  String name = '';

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        name = observation.telescopeName;
        break;
      case 1:
        name = observation.detectorName;
        break;
      case 2:
        name = observation.sObject!.name;
        break;
      case 3:
        name = observation.filterName;
        break;
      case 4:
        name = observation.type;
        break;
      default:
    }
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 4),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: info.color!.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    color: info.color,
                  ),
                ),
                Text(
                  info.title!,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: 40,
                )
              ],
            ),
          ),
          Text(
            name,
            maxLines: 1,
            style: const TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
