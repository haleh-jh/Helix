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
  final String path;
  final List list;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final EditCallback<T>? editFunction;
  final EditCallback<T>? deleteFunction;
 // final Function(Data data)? deleteFunction;
  var progressController;
  bool isObject;

  RecentFiles(
      {Key? key,
      required this.title,
      required this.scaffoldKey,
      required this.path,
      required this.list,
      this.editFunction,
      this.deleteFunction,
      this.progressController,
      this.isObject = false,})
      : super(key: key);

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
                    child:
                     DataTable2(
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: widget.isObject? SObjectsDataTable() : (widget.list is List<FramesModel>)? FramesDataTable() : (widget.list is List<User>)? UsersDataTable() : TelescopDataTable(),
                      rows: List.generate(
                        widget.list.length,
                        (index) => recentFileDataRow(
                          widget.list[index],
                          context,
                        ),
                      ),
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

  onPressedButton(BuildContext c, var data) {
    showDialog(
        context: c,
        builder: (context) {
          return CustomDialog(
              path: widget.path,
              formKey: _formKey,
              scaffoldKey: widget.scaffoldKey,
              c: context,
              f: widget.editFunction,
              progressController: widget.progressController,
              btnTitle: "Edit",
              data: data);
        });
  }

  onPressedDeleteButton(BuildContext c, var data) async{
   await showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
              path: widget.path,
              c: context,
              deleteFunction: widget.deleteFunction,
              progressController: widget.progressController,
              title: 'Are you sure you want to delete this object?',
              data: data);
        });
  }

  DataRow recentFileDataRow(var fileInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
             (fileInfo is User)? Text("${fileInfo.userName} ${fileInfo.lastName}") : Text(fileInfo.name!),
            ],
          ),
        ),
        DataCell(Text((fileInfo is SObjects) ? "${fileInfo.coordinate!.ra} ; ${fileInfo.coordinate!.dec}" : (fileInfo is FramesModel)? "${fileInfo.type} ; ${fileInfo.filter}" :(fileInfo is User)? fileInfo.phoneNumber : fileInfo.type!)),
        DataCell(
          Row(
            children: [
              Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: kEditIconColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: InkWell(
                    onTap: () {
                      selectedId = fileInfo.id;
                      onPressedButton(context, fileInfo);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: kDeleteIconColor,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: InkWell(
                      onTap: (() {
                        selectedId = fileInfo.id;
                        onPressedDeleteButton(context, fileInfo);
                      }),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
