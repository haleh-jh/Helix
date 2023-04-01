import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/texts.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/widgets/header.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/widgets/search_screen_horizontal.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';

class DashboardScreen extends StatelessWidget {
  Function(int) profileSelected;
  Function() logout;

//ValueNotifier<List<ObservationModel>> searchList = ValueNotifier([]);
  ValueNotifier<bool> searchResult = ValueNotifier(false);

  final ValueNotifier<DataModel?> telescopeValue = ValueNotifier(null);
  final ValueNotifier<DataModel?> detectorValue = ValueNotifier(null);
  final ValueNotifier<DataModel?> objectValue = ValueNotifier(null);
  final ValueNotifier<DataModel?> frameValue = ValueNotifier(null);

  final bloc = injector<DashboardBloc>();

  DashboardScreen(
      {Key? key, required this.profileSelected, required this.logout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.add(const DashboardEvent.started());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(
                title: dashboard,
                profileSelected: () {
                  profileSelected(dashboardIndex);
                },
                logout: logout,
              ),
              const SizedBox(height: defaultPadding),
              BlocBuilder<DashboardBloc, DashboardState>(
                bloc: bloc,
                builder: (context, state) {
                return state.when(init: (){
                  return Container();
                }, success: (telescopeList, detectorList, frameList, objectList){
                    return Row(
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
                            // ValueListenableBuilder(
                            //   valueListenable: searchList,
                            //   builder: (context, value, child) {
                            //     return searchList.value.length > 0
                            //         ? Container(
                            //             padding:
                            //                 const EdgeInsets.all(defaultPadding),
                            //             decoration: const BoxDecoration(
                            //               color: serachBackground,
                            //               borderRadius:
                            //                   BorderRadius.all(Radius.circular(10)),
                            //             ),
                            //             child: SearchPart())
                            //         : searchResult.value
                            //             ? Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 crossAxisAlignment:
                            //                     CrossAxisAlignment.center,
                            //                 children: const [
                            //                   Padding(
                            //                     padding: EdgeInsets.only(
                            //                         top: height * 2),
                            //                     child: Text(
                            //                       kNotExistObservation,
                            //                       style: TextStyle(
                            //                         fontSize: 18,
                            //                         fontWeight: FontWeight.w500,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               )
                            //             : Container();
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        const SizedBox(width: defaultPadding),
                    ],
                  );
                
                });

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  onSearch(dynamic value) {
    // searchList.value.clear();
    // if (value.length == 0) {
    //   searchResult.value = true;
    // } else
    //   searchResult.value = false;
    // searchList.value = value;
  }
}
