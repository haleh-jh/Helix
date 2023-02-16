import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/filters.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/cards_widget.dart';
import 'package:admin/screens/dashboard/components/custom_text_field.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import '../../../data/models/data.dart';
import 'storage_info_card.dart';

ValueNotifier<bool> loading = ValueNotifier(false);

class SearchScreenHorizontal extends StatefulWidget {
  final Function(dynamic value) onSearch;
  final ValueNotifier<GeneralModel?> telescopeValue;
  final ValueNotifier<GeneralModel?> detectorValue;
  final ValueNotifier<GeneralModel?> objectValue;
  final ValueNotifier<GeneralModel?> frameValue;
  List<TextEditingController> controllers = [];
  SearchScreenHorizontal({
    Key? key,
    required this.onSearch,
    required this.telescopeValue,
    required this.detectorValue,
    required this.objectValue,
    required this.frameValue,
  }) : super(key: key);

  @override
  State<SearchScreenHorizontal> createState() => _SearchScreenHorizontalState();
}

class _SearchScreenHorizontalState extends State<SearchScreenHorizontal> {
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
    final Size _size = MediaQuery.of(context).size;
    widget.controllers.clear();
    widget.controllers.addAll([
      coordinateRaController,
      coordinateDecController,
      radiusController,
      userController
    ]);
    print("_size: ${_size.width}");
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Responsive(
            mobile: Column(
              children: [
                HorizonalSearchGridView(
                  crossAxisCount: 2,
                  childAspectRatio: (_size.width / 2) / 16.h,
                  telescopeValue: widget.telescopeValue,
                  detectorValue: widget.detectorValue,
                  frameValue: widget.frameValue,
                  objectValue: widget.objectValue,
                  controllers: widget.controllers,
                ),
              ],
            ),
            tablet: HorizonalSearchGridView(
              crossAxisCount: 2,
              childAspectRatio: (_size.width / 2) / 16.h,
              telescopeValue: widget.telescopeValue,
              detectorValue: widget.detectorValue,
              frameValue: widget.frameValue,
              objectValue: widget.objectValue,
              controllers: widget.controllers,
            ),
            desktop: HorizonalSearchGridView(
              crossAxisCount: 4,
              childAspectRatio: (_size.width / 4) / 18.h,
              telescopeValue: widget.telescopeValue,
              detectorValue: widget.detectorValue,
              frameValue: widget.frameValue,
              objectValue: widget.objectValue,
              controllers: widget.controllers,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: CustomTextField(
                  controller: dateFromController,
                  hint: "Date Of",
                  iconData: Icons.calendar_today,
                  iconColor: Color(0xffffa113),
                ),
              ),
              Expanded(flex: 1, child: SizedBox(height: defaultPadding)),
              Expanded(
                flex: 3,
                child: CustomTextField(
                  controller: dateToController,
                  hint: "Date To",
                  iconData: Icons.calendar_today,
                  iconColor: Color(0xffff4387),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: ValueListenableBuilder(
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
                                            (Responsive.isMobile(context)
                                                ? 2
                                                : 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      searchList.value = [];
                                      String telescope = "";
                                      String detector = "";
                                      String object = "";
                                      String frame = "";
                                      telescope = telescopeValue.value == null
                                          ? ""
                                          : telescopeValue.value!.value;
                                      detector = detectorValue.value == null
                                          ? ""
                                          : detectorValue.value!.value;
                                      object = objectValue.value == null
                                          ? ""
                                          : objectValue.value!.value;
                                      frame = frameValue.value == null
                                          ? ""
                                          : frameValue.value!.value;

                                      loading.value = true;
                                      var data = {
                                        'FrameName': frame,
                                        'TelescopeName': telescope,
                                        'SObjectName': object,
                                        'DetectorName': detector,
                                        'DateOf': dateFromController.text,
                                        'DateTo': dateToController.text,
                                        'User': userController.text,
                                        'ra': coordinateRaController.text,
                                        'dec': coordinateDecController.text,
                                        'radius': radiusController.text,
                                        'SortByTelescope': '0',
                                        'SortByFrame': '0',
                                        'SortSObject': '0',
                                        'SortDetector': '0',
                                        'SortDate': '0'
                                      };
                                      search(data);
                                    },
                                    icon: SvgPicture.asset(
                                        "assets/icons/Search.svg"),
                                    label: Text("Search"),
                                  ),
                          ],
                        );
                      })))
            ],
          ),
        ],
      ),
    );
  }

  search(var data) async {
    try {
      await myProvider.search(context, data).then((value) {
        print("tt3: ${value}}");
        widget.onSearch(value);
        loading.value = false;
      });
    } catch (e) {
      loading.value = false;
    }
  }
}

class HorizonalSearchGridView extends StatelessWidget {
  const HorizonalSearchGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 2,
    required this.telescopeValue,
    required this.detectorValue,
    required this.objectValue,
    required this.frameValue,
    required this.controllers,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final ValueNotifier<GeneralModel?> telescopeValue;
  final ValueNotifier<GeneralModel?> detectorValue;
  final ValueNotifier<GeneralModel?> objectValue;
  final ValueNotifier<GeneralModel?> frameValue;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: demoObjectInfo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              CloudStorageInfo data = demoObjectInfo[index];
              return StorageInfoCard(
                svgSrc: data.svgSrc!,
                title: data.title!,
                onTap: () async {
                  //                  context.watch<DataController>().getTelescopeDropDownList;
                },
                telescopeValue: telescopeValue,
                detectorValue: detectorValue,
                frameValue: frameValue,
                objectValue: objectValue,
              );
            }),
        SizedBox(height: defaultPadding),
        HorizonalSearchTextField(
          controllers: controllers,
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}

class HorizonalSearchTextField extends StatelessWidget {
  const HorizonalSearchTextField({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 2,
    required this.controllers,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: demoOtherObjectInfo.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          CloudStorageInfo data = demoOtherObjectInfo[index];
          print(index);
          return CustomTextField(
            controller: controllers[index],
            hint: data.title!,
            iconData: data.icon!,
            iconColor: data.color!,
          );
        });
  }
}
