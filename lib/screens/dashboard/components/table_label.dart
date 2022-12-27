import 'package:admin/constants.dart';
import 'package:admin/data/models/observation.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<DataColumn> TelescopDataTable() {
  return [
    DataColumn(
      label: Text("Name"),
    ),
    DataColumn(
      label: Text("Type"),
    ),
    DataColumn(
      label: Text("Actions"),
    ),
  ];
}

List<DataColumn> SObjectsDataTable() {
  return [
    DataColumn(
      label: Text("Name"),
    ),
    DataColumn(
      label: Text("Coordinate"),
    ),
    DataColumn(
      label: Text("Actions"),
    ),
  ];
}

List<DataColumn> FramesDataTable() {
  return [
    DataColumn(
      label: Text("Name"),
    ),
    DataColumn(
      label: Text("Type / Filter"),
    ),
    DataColumn(
      label: Text("Actions"),
    ),
  ];
}

List<DataColumn> ObservationDataTable() {
  return [
    DataColumn(
      label: Text("User name"),
    ),
    DataColumn(
      label: Text("Telescope"),
    ),
    DataColumn(
      label: Text("Detector"),
    ),
    DataColumn(
      label: Text("Observation"),
    ),
    DataColumn(
      label: Text("Frame"),
    ),
    DataColumn(
      label: Text("Actions"),
    ),
  ];
}

List<DataColumn> SearchObservationDataTable() {
  return [
    DataColumn(
      label: Text("User name"),
    ),
    DataColumn(
      label: Text("Telescope"),
    ),
    DataColumn(
      label: Text("Detector"),
    ),
    DataColumn(
      label: Text("Observation"),
    ),
    DataColumn(
      label: Text("Frame"),
    ),
  ];
}

List<DataColumn> UsersDataTable() {
  return [
    DataColumn(
      label: Text("Name"),
    ),
    DataColumn(
      label: Text("Phone"),
    ),
    DataColumn(
      label: Text("Actions"),
    ),
  ];
}

List<DataRow2> TelescopeDataRow(int length, var fileInfo, BuildContext context,
    Function deleteOnTap, Function editOnTap) {
  return List.generate(length, (index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              Text(fileInfo[index].name!),
            ],
          ),
        ),
        DataCell(Text(fileInfo[index].type!)),
        DataCell(
          RecentFileActionRow(
            deleteOnTap: (info) {
              deleteOnTap!(context, info);
            },
            editOnTap: (info) {
              editOnTap!(context, info);
            },
            fileInfo: fileInfo[index],
          ),
        ),
      ],
    );
    ;
  });
}

List<DataRow2> UserDataRow(int length, var fileInfo, BuildContext context,
    Function deleteOnTap, Function editOnTap) {
  return List.generate(length, (index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              Text("${fileInfo[index].userName} ${fileInfo[index].lastName}")
            ],
          ),
        ),
        DataCell(Text(fileInfo[index].phoneNumber)),
        DataCell(
          RecentFileActionRow(
            deleteOnTap: (info) {
              deleteOnTap!(context, info);
            },
            editOnTap: (info) {
              editOnTap!(context, info);
            },
            fileInfo: fileInfo[index],
          ),
        ),
      ],
    );
  });
}

List<DataRow2> SObjectDataRow(int length, var fileInfo, BuildContext context,
    Function deleteOnTap, Function editOnTap) {
  return List.generate(length, (index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [Text(fileInfo[index].name!)],
          ),
        ),
        DataCell(Text("${fileInfo[index].ra} ; ${fileInfo[index].dec}")),
        DataCell(
          RecentFileActionRow(
            deleteOnTap: (info) {
              deleteOnTap!(context, info);
            },
            editOnTap: (info) {
              editOnTap!(context, info);
            },
            fileInfo: fileInfo[index],
          ),
        ),
      ],
    );
    ;
  });
}

List<DataRow2> FrameDataRow(int length, var fileInfo, BuildContext context,
    Function deleteOnTap, Function editOnTap) {
  return List.generate(length, (index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              Text(fileInfo[index].name!),
            ],
          ),
        ),
        DataCell(Text("${fileInfo[index].type} ; ${fileInfo[index].filter}")),
        DataCell(
          RecentFileActionRow(
            deleteOnTap: (info) {
              deleteOnTap!(context, info);
            },
            editOnTap: (info) {
              editOnTap!(context, info);
            },
            fileInfo: fileInfo[index],
          ),
        ),
      ],
    );
    ;
  });
}

List<DataRow2> ObservationDataRow(
    int length,
    var fileInfo,
    BuildContext context,
    Function deleteOnTap,
    Function editOnTap,
    bool search) {
  return List.generate(length, (index) {
    ObservationsModel model = fileInfo[index];
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              //   Text(fileInfo[index].user.userName!?? ""),
              Text(
                model.userName ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        DataCell(Text("${model.telescopeName ?? ""}")),
        DataCell(Text("${model.detectorName ?? ""}")),
        DataCell(Text("${model.sObject!.name ?? ""}")),
        DataCell(Text("${model.frameName ?? ""}")),
        if (!search) ...{
          DataCell(
            RecentFileActionRow(
              deleteOnTap: (info) {
                deleteOnTap!(context, info);
              },
              editOnTap: (info) {
                editOnTap!(context, info);
              },
              fileInfo: fileInfo[index],
            ),
          ),
        }
      ],
    );
    ;
  });
}

// selectedId = fileInfo.id;
// onPressedButton(context, fileInfo);

// selectedId = fileInfo.id;
// onPressedDeleteButton(context, fileInfo);

class RecentFileActionRow extends StatelessWidget {
  Function(dynamic info)? deleteOnTap;
  Function(dynamic info)? editOnTap;
  var fileInfo;
  RecentFileActionRow(
      {Key? key, this.deleteOnTap, this.editOnTap, this.fileInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                editOnTap!(fileInfo);
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
                onTap: () {
                  print("eh: ${fileInfo}");
                  deleteOnTap!(fileInfo);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }
}
