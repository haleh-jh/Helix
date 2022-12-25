import 'dart:ui';

import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/custom_fun.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/user.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/table_label.dart';
import 'package:admin/screens/main/components/custom_alert_dialog.dart';
import 'package:admin/screens/main/components/custom_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

typedef EditCallback<T> = void Function(T value);

class RecentFiles<T> extends StatefulWidget {
  final String title;
  final List list;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<DataColumn> dataColumnList;
  final List<DataRow> dataRowList;
  // final Function(Data data)? deleteFunction;
  var progressController;
  bool isObject;

  RecentFiles({
    Key? key,
    required this.title,
    required this.scaffoldKey,
    required this.list,
    this.progressController,
    this.isObject = false,
    required this.dataColumnList,
     required this.dataRowList,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  final _formKey = GlobalKey<FormState>();
  var progressProvider;
  late int selectedId;

  @override
  void initState() {
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
            widget.title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Consumer<DataController>(builder: ((context, value, child) {
            return widget.list.length == 0
                ? Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: 50,
                        child: ValueListenableBuilder(
                            valueListenable: DataController.ProgressNotifier,
                            builder: (context, value, child) {
                              return Visibility(
                                  visible:
                                      DataController.ProgressNotifier.value,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ));
                            })),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: DataTable2(
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: widget.dataColumnList,
                      rows: widget.dataRowList
                    ),
                  );
          })),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

}
