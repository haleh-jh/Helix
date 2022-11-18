import 'package:admin/constants.dart';
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

