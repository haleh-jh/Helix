import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/card_info.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/custom_text_field.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/info_card.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchScreenHorizontal extends StatefulWidget {
  final ValueNotifier<bool> loading;
  List<TextEditingController> controllers = [];
  SearchScreenHorizontal({
    Key? key, required this.loading,
  }) : super(key: key);

  @override
  State<SearchScreenHorizontal> createState() => _SearchScreenHorizontalState();
}

late ValueNotifier<DataModel?> telescopeValue = ValueNotifier(null);
late ValueNotifier<DataModel?> detectorValue = ValueNotifier(null);
late ValueNotifier<DataModel?> objectValue = ValueNotifier(null);
late ValueNotifier<DataModel?> frameValue = ValueNotifier(null);

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

  late final bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<DashboardBloc>();
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
    //    telescopeValue = ValueNotifier(null);
    //  detectorValue = ValueNotifier(null);
    //  objectValue = ValueNotifier(null);
    // frameValue = ValueNotifier(null);

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  telescopeValue: telescopeValue,
                  detectorValue: detectorValue,
                  frameValue: frameValue,
                  objectValue: objectValue,
                  controllers: widget.controllers,
                ),
              ],
            ),
            tablet: HorizonalSearchGridView(
              crossAxisCount: 2,
              childAspectRatio: (_size.width / 2) / 16.h,
              telescopeValue: telescopeValue,
              detectorValue: detectorValue,
              frameValue: frameValue,
              objectValue: objectValue,
              controllers: widget.controllers,
            ),
            desktop: HorizonalSearchGridView(
              crossAxisCount: 4,
              childAspectRatio: (_size.width / 4) / 18.h,
              telescopeValue: telescopeValue,
              detectorValue: detectorValue,
              frameValue: frameValue,
              objectValue: objectValue,
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
                  iconColor: const Color(0xffffa113),
                ),
              ),
              const Expanded(flex: 1, child: SizedBox(height: defaultPadding)),
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
                      valueListenable: widget.loading,
                      builder: ((context, value, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.loading.value
                                ? const SizedBox(
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
                                    onPressed: () async {
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

                                      widget.loading.value = true;
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
                                      await context
                                          .read<DashboardBloc>()
                                          .onSearch(data);
                                      widget.loading.value = false;
                                    },
                                    icon: SvgPicture.asset(
                                        "assets/icons/Search.svg"),
                                    label: const Text("Search"),
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
  final ValueNotifier<DataModel?> telescopeValue;
  final ValueNotifier<DataModel?> detectorValue;
  final ValueNotifier<DataModel?> objectValue;
  final ValueNotifier<DataModel?> frameValue;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: MainObjectInfo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              TotalInfo data = MainObjectInfo[index];
              return InfoCard(
                svgSrc: data.svgSrc!,
                title: data.title!,
                telescopeValue: telescopeValue,
                detectorValue: detectorValue,
                frameValue: frameValue,
                objectValue: objectValue,
                index: index,
              );
            }),
        const SizedBox(height: defaultPadding),
        HorizonalSearchTextField(
          controllers: controllers,
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
        ),
        const SizedBox(height: defaultPadding),
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
        itemCount: OtherObjectInfo.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) {
          TotalInfo data = OtherObjectInfo[index];
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
