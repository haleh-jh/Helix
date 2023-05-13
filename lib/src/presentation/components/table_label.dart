import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';

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

List<DataColumn> FiltersDataTable() {
  return [
    DataColumn(
      label: Text("Name"),
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
      label: Text("Object"),
    ),
    DataColumn(
      label: Text("Filter"),
    ),
    DataColumn(
      label: Text("Status"),
    ),
    DataColumn(
      label: Text(""),
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
      label: Text("Object"),
    ),
    DataColumn(
      label: Text("Filter"),
    ),
    DataColumn(
      label: Text(""),
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
    Function(dynamic info) viewOnTap,
    bool search) {
  return List.generate(length, (index) {
    ObservationsModel model = fileInfo[index];
    print(model.id);
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
        DataCell(Text("${model.filterName ?? ""}")),
        if (!search) ...{
          DataCell(Text(
            "${model.status ?? ""}",
            style: TextStyle(
                color: model.status.contains('True')
                    ? Color(0xff26e5ff)
                    : Color(0xffee2727)),
          ))
        },
        DataCell(InkWell(
          onTap: () {
            viewOnTap(fileInfo[index]);
          },
          child: const Icon(
            Icons.remove_red_eye,
            color: Color(0xff26e5ff),
          ),
        )),
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
            decoration: const BoxDecoration(
              color: kEditIconColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: InkWell(
              onTap: () {
                editOnTap!(fileInfo);
              },
              child: const Icon(
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
              decoration: const BoxDecoration(
                color: kDeleteIconColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: InkWell(
                onTap: () {
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
