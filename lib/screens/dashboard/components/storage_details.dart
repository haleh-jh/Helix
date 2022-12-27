import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/cards_widget.dart';
import 'package:admin/screens/dashboard/components/custom_text_field.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../data/models/data.dart';
import 'storage_info_card.dart';

ValueNotifier<bool> loading = ValueNotifier(false);

class StarageDetails extends StatefulWidget {
  final Function(dynamic value) onSearch;
  final ValueNotifier<GeneralModel?> telescopeValue;
  final ValueNotifier<GeneralModel?> detectorValue;
  final ValueNotifier<GeneralModel?> objectValue;
  final ValueNotifier<GeneralModel?> frameValue;
  const StarageDetails({
    Key? key,
    required this.onSearch,
    required this.telescopeValue,
    required this.detectorValue,
    required this.objectValue,
    required this.frameValue,
  }) : super(key: key);

  @override
  State<StarageDetails> createState() => _StarageDetailsState();
}

class _StarageDetailsState extends State<StarageDetails> {
  late final myProvider;
  ValueNotifier<String> timeFrom = ValueNotifier('');
  ValueNotifier<String> timeTo = ValueNotifier('');
  TextEditingController userController = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController coordinateRaController = TextEditingController();
  TextEditingController coordinateDecController = TextEditingController();
  TextEditingController radiusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myProvider = Provider.of<DataController>(context, listen: false);
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
          CardsWidget(
            telescopeValue: widget.telescopeValue,
            detectorValue: widget.detectorValue,
            frameValue: widget.frameValue,
            objectValue: widget.objectValue,
          ),
          SizedBox(height: defaultPadding),
          CustomTextField(
            controller: coordinateRaController,
            hint: "Coordinate ra",
            iconData: Icons.calculate,
            iconColor: Color(0xffffa113),
          ),
          SizedBox(height: defaultPadding),
          CustomTextField(
            controller: coordinateDecController,
            hint: "Coordinate dec",
            iconData: Icons.calculate,
            iconColor: Color(0xffffa113),
          ),
          SizedBox(height: defaultPadding),
          CustomTextField(
            controller: radiusController,
            hint: "Radius",
            iconData: Icons.circle,
            iconColor: Color(0xffffa113),
          ),
          SizedBox(height: defaultPadding),
          CustomTextField(
            controller: userController,
            hint: "User",
            iconData: Icons.person_rounded,
            iconColor: Color(0xff2697ff),
          ),
          SizedBox(height: defaultPadding),
          CustomTextField(
            controller: dateFromController,
            hint: "Date Of",
            iconData: Icons.calendar_today,
            iconColor: Color(0xffffa113),
          ),
          SizedBox(height: defaultPadding),
          CustomTextField(
            controller: dateToController,
            hint: "Date To",
            iconData: Icons.calendar_today,
            iconColor: Color(0xffff4387),
          ),
          SizedBox(height: defaultPadding),
          ValueListenableBuilder(
              valueListenable: loading,
              builder: ((context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading.value
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding /
                                    (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              String telescope = "";
                              String detector = "";
                              String object = "";
                              String frame = "";
                              telescopeValue.value == null
                                  ? telescope = ""
                                  : telescopeValue.value!.value;
                              detectorValue.value == null
                                  ? detector = ""
                                  : detectorValue.value!.value;
                              objectValue.value == null
                                  ? object = ""
                                  : objectValue.value!.value;
                              frameValue.value == null
                                  ? frame = ""
                                  : frameValue.value!.value;

                              // if (frameValue.value!.value.length > 0 &&
                              //     telescopeValue.value!.value.length > 0 &&
                              //     objectValue.value!.value.length > 0 &&
                              //     detectorValue.value!.value.length > 0 &&
                              //     userController.text.length > 0 &&
                              //     dateFromController.text.length > 0 &&
                              //     dateToController.text.length > 0 &&
                              //     userController.text.length > 0) {
                              loading.value = true;
                              var data = {
                                'FrameName': frame,
                                'TelescopeName': telescope,
                                'SObjectName': object,
                                'DetectorName': detector,
                                'DateOf': dateFromController.text,
                                'DateTo': dateToController.text,
                                'User': userController.text,
                                'SortByTelescope': '0',
                                'SortByFrame': '0',
                                'SortSObject': '0',
                                'SortDetector': '0',
                                'SortDate': '0'
                              };
                              search(data);
                              //     } else {}
                            },
                            icon: SvgPicture.asset("assets/icons/Search.svg"),
                            label: Text("Search"),
                          ),
                  ],
                );
              }))
        ],
      ),
    );
  }

  search(var data) async {
    try {
      await myProvider.search(data).then((value) {
        widget.onSearch(value);
        loading.value = false;
      });
    } catch (e) {
      loading.value = false;
    }
  }
}
