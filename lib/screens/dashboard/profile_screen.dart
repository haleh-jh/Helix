import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var providerType = Provider.of<DataController>(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: ProfileWidget(
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  ProfileWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  TextEditingController NameController = TextEditingController();
  TextEditingController TypeController = TextEditingController();
  late final myProvider;
  var progressController = ProgressController();

  final _formKey = GlobalKey<FormState>();
  var progressProvider;

  @override
  void initState() {
    super.initState();
    myProvider = Provider.of<DataController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    DataController.ProgressNotifier = ValueNotifier(true);
    myProvider.getAll(
        context, myProvider.getUserObservationsList, UserObservationPath);
    return Column(
      children: [
        Stack(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 64),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    'assets/images/sahabi.jpeg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                )),
            Positioned(
              bottom: 32,
              right: 20.5.w,
              left: 20.5.w,
              child: Container(
                height: 34,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Color.fromARGB(255, 133, 133, 133))
                ]),
              ),
            ),
            Positioned(
                bottom: 32,
                right: 20.w,
                left: 20.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: secondaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: SvgPicture.asset(
                                "assets/icons/profile.svg",
                                height: 70,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //                          await setString("id", user.id);
                                  //  await setString("userName", user.userName);
                                  //  await setString("email", user.email);
                                  //  await setString("type", user.type);
                                  //  await setString("surname", user.surname);
                                  //  await setString("lastName", user.lastName);
                                  //  await setString("institution", user.institution);
                                  //  await setString("phoneNumber", user.phoneNumber);
                                  //  await setBool("emailConfirmed", user.emailConfirmed);
                                  //  await setBool("phoneNumberConfirmed", user.phoneNumberConfirmed);

                                  Text(
                                      "${PreferenceUtils.getString("userName")} ${PreferenceUtils.getString("lastName")}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 3.sp)),

                                  Text("${PreferenceUtils.getString("email")}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 3.sp)),

                                  Text(
                                      "${PreferenceUtils.getString("phoneNumber")}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 3.sp))
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
        SizedBox(height: defaultPadding),
        ValueListenableBuilder(
            valueListenable: myProvider.getUserObservationsList,
            builder: (context, value, child) {
              return RecentFiles(
                title: "User Observations",
                tableHeight: MediaQuery.of(context).size.height * 0.5,
                scaffoldKey: widget.scaffoldKey,
                progressController: progressController,
                list: myProvider.getUserObservationsList.value,
                dataRowList: ObservationDataRow(
                    myProvider.getUserObservationsList.value.length,
                    myProvider.getUserObservationsList.value,
                    context,
                    () {},
                    () {}, (fileinfo) {
                  //   onPressedViewButton(context, fileinfo);
                }, false),
                dataColumnList: ObservationDataTable(),
              );
            })
      ],
    );
  }
}
