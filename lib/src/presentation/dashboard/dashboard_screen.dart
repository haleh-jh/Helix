import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/texts.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/widgets/header.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/widgets/search_part.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/widgets/search_screen_horizontal.dart';
import 'package:helix_with_clean_architecture/src/presentation/main_screen/main_screen.dart';

class DashboardScreen extends StatefulWidget {
  Function(int) profileSelected;
  Function() logout;

  DashboardScreen(
      {Key? key, required this.profileSelected, required this.logout})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final bloc = injector<DashboardBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(const DashboardEvent.started());
  }

  ValueNotifier<bool> loading = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(
                title: dashboard,
                profileSelected: () {
                  widget.profileSelected(dashboardIndex);
                },
                logout: widget.logout,
              ),
              const SizedBox(height: defaultPadding),
              BlocBuilder<DashboardBloc, DashboardState>(
                bloc: bloc,
                builder: (context, state) {
                  loading.value = false;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            BlocProvider.value(
                              value: bloc,
                              child: SearchScreenHorizontal(loading: loading,),
                            ),
                            const SizedBox(height: defaultPadding),
                            state.when(init: () {
                              return Container();
                            }, success: () {
                              return Container();
                            }, searchLoading: () {
                              return Container();
                            }, searchSuccess:
                                (List<ObservationsModel> observations) {
                              return observations.isNotEmpty
                                  ? Container(
                                      padding:
                                          const EdgeInsets.all(defaultPadding),
                                      decoration: const BoxDecoration(
                                        color: serachBackground,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: SearchPart(
                                        observations: observations,
                                      ))
                                  : bloc.searchResult
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * 2),
                                              child: Text(
                                                kNotExistObservation,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container();
                            }, searchFailed: () {
                              return Container();
                            })
                          ],
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        const SizedBox(width: defaultPadding),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
