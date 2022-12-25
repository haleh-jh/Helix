import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//ValueNotifier<Data?> telescopeValue = ValueNotifier(null);

class TelescopeDropDown extends StatelessWidget {
  final ValueNotifier<GeneralModel?> telescopeValue;
  const TelescopeDropDown({
    Key? key,
    required this.title, required this.telescopeValue,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    print("check: ${telescopeValue.value}");
    return ValueListenableBuilder(
        valueListenable: telescopeValue,
        builder: (context, value, child) {
          return DropdownButton<GeneralModel>(
            hint: Text(title),
            value: telescopeValue.value,
            isExpanded: true,
            onChanged: (newValue) {
              telescopeValue.value = newValue;
            },
            items:
                context.watch<DataController>().getTelescopeDropDownList.map((data) {
              return new DropdownMenuItem<GeneralModel>(
                value: data,
                child: new Text(
                  data.value,
                ),
              );
            }).toList(),
          );
        });
  }
}
