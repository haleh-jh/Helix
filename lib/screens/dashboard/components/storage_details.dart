import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatefulWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<StarageDetails> createState() => _StarageDetailsState();
}

class _StarageDetailsState extends State<StarageDetails> {
  late final myProvider;

  @override
  void initState() {
    myProvider = Provider.of<DataController>(context, listen: false);
    DataController.ProgressNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          //  Chart(),
          StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Telescope",
            onTap: () async {
              await myProvider.getAll(
                  context, myProvider.getTelescopeList, telescope);
              context
                  .read<ListDataController>()
                  .telescopeSetSValue(myProvider.getTelescopeList[0].name);
              context
                  .read<ListDataController>()
                  .telescopeSetValue(myProvider.getTelescopeList);
            },
            onChange: ((v) {
              context.read<ListDataController>().telescopeSetSValue(v);
            }),
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Detector",
            onTap: () async {
              print("object");
              await myProvider.getAll(
                  context, myProvider.getDetectorsList, detector);
              context
                  .read<ListDataController>()
                  .detectorSetValue(myProvider.getDetectorsList);
            },
            onChange: (v) {},
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Object",
            onTap: () async {
              await myProvider.getAll(
                  context, myProvider.getSObjectsList, Objects);
              context
                  .read<ListDataController>()
                  .objectSetValue(myProvider.getSObjectsList);
            },
            onChange: (v) {},
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Frame",
            onTap: () async {
              await myProvider.getAll(
                  context, myProvider.getFramesList, Frames);
              context
                  .read<ListDataController>()
                  .frameSetValue(myProvider.getFramesList);
            },
            onChange: (v) {},
          ),

          SizedBox(height: defaultPadding),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset("assets/icons/Search.svg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
