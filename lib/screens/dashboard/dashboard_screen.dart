import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/exception.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/search_screen_horizontal.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/view_detail_dialog.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/header.dart';

final ValueNotifier<GeneralModel?> telescopeValue = ValueNotifier(null);
final ValueNotifier<GeneralModel?> detectorValue = ValueNotifier(null);
final ValueNotifier<GeneralModel?> objectValue = ValueNotifier(null);
final ValueNotifier<GeneralModel?> frameValue = ValueNotifier(null);

ValueNotifier<List<ObservationsModel>> searchList = ValueNotifier([]);
ValueNotifier<bool> searchResult = ValueNotifier(false);

class DashboardScreen extends StatefulWidget {
  Function(int) profileSelected;
  Function() logout;
  static ValueNotifier<bool> loading = ValueNotifier(false);

  DashboardScreen(
      {Key? key, required this.profileSelected, required this.logout})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late DataController myProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareData(context);
    myProvider = Provider.of<DataController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(
                title: "Dashboard",
                profileSelected: () {
                  widget.profileSelected(dashboardIndex);
                },
                logout: widget.logout,
              ),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SearchScreenHorizontal(
                          onSearch: onSearch,
                          detectorValue: detectorValue,
                          frameValue: frameValue,
                          objectValue: objectValue,
                          telescopeValue: telescopeValue,
                        ),
                        SizedBox(height: defaultPadding),
                        ValueListenableBuilder(
                          valueListenable: searchList,
                          builder: (context, value, child) {
                            return searchList.value.length > 0
                                ? Container(
                                    padding: EdgeInsets.all(defaultPadding),
                                    decoration: BoxDecoration(
                                      color: serachBackground,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: SearchPart())
                                : searchResult.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: height * 2),
                                            child: Text(
                                              "There is no Observation recorded in this date",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearch(dynamic value) {
    searchList.value.clear();
    if (value.length == 0) {
      searchResult.value = true;
    } else
      searchResult.value = false;
    searchList.value = value;
  }
}

Future<void> prepareData(BuildContext context) async {
  DataController myProvider =
      Provider.of<DataController>(context, listen: false);
  DataController.ProgressNotifier = ValueNotifier(false);

  await setdataList(context, myProvider, myProvider.getTelescopeDropDownList,
      telescopeDropDown);
  await setdataList(context, myProvider, myProvider.getDetectorDropDownList,
      detectorDropDown);
  await setdataList(
      context, myProvider, myProvider.getSObjectDropDownList, objectDropDown);
  await setdataList(
      context, myProvider, myProvider.getFrameDropDownList, frameDropDown);
}

Future<void> setdataList(BuildContext context, DataController myProvider,
    List<GeneralModel> list, String path) async {
  try {
    await myProvider.getDropDownList(context, list, path);
  } catch (e) {
    if (e is AppException) {
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackbar.customErrorSnackbar(e.message, context));
    }
  }
}

class SearchPart extends StatelessWidget {
  const SearchPart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 400,
              columns: SearchObservationDataTable(),
              rows: ObservationDataRow(searchList.value.length,
                  searchList.value, context, () {}, () {}, (fileinfo) {
                onPressedViewButton(context, fileinfo);
              }, true)),
        ),
      ],
    );
  }

  onPressedViewButton(BuildContext c, var data) async {
    final listDataController = Provider.of<DataController>(c, listen: false);
    await showDialog(
        context: c,
        builder: (_) {
          return ListenableProvider<DataController>.value(
              value: listDataController,
              child: ViewDetailDialog(
                c: c,
                observation: data,
                ObservationId: data.id,
              ));
        });
  }
}
