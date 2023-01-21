import 'package:admin/controllers/DataController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/filters.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/screens/dashboard/components/storage_info_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsWidget extends StatelessWidget {
  final ValueNotifier<GeneralModel?> telescopeValue;
  final ValueNotifier<GeneralModel?> detectorValue;
  final ValueNotifier<GeneralModel?> objectValue;
  final ValueNotifier<GeneralModel?> frameValue;
  CardsWidget({
    Key? key,
    required this.telescopeValue,
    required this.detectorValue,
    required this.objectValue,
    required this.frameValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Optic",
            onTap: () async {
           //   context.watch<DataController>().getTelescopeDropDownList;
            },
            telescopeValue: telescopeValue,
            detectorValue: detectorValue,
            frameValue: frameValue,
            objectValue: objectValue,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Detector",
            onTap: () async {
            //  context.watch<DataController>().getTelescopeDropDownList;
            },
            telescopeValue: telescopeValue,
            detectorValue: detectorValue,
            frameValue: frameValue,
            objectValue: objectValue,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Object",
            onTap: () async {
           //   context.watch<DataController>().getTelescopeDropDownList;
            },
            telescopeValue: telescopeValue,
            detectorValue: detectorValue,
            frameValue: frameValue,
            objectValue: objectValue,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Filter",
            onTap: () async {
          //                  context.watch<DataController>().getTelescopeDropDownList;
            },
            telescopeValue: telescopeValue,
            detectorValue: detectorValue,
            frameValue: frameValue,
            objectValue: objectValue,
          ),
        ],
      ),
    );
  }
}
