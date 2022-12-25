import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:admin/data/models/object.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObjectDropDown extends StatelessWidget {
  final ValueNotifier<GeneralModel?> objectValue;
 ObjectDropDown({
    Key? key,
    required this.title, required this.objectValue,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
 return ValueListenableBuilder(
        valueListenable: objectValue,
        builder: (context, value, child) {
          return DropdownButton<GeneralModel>(
            hint: Text(title),
            value: objectValue.value,
            isExpanded: true,
            onChanged: (newValue) {
              objectValue.value = newValue;
            },
            items:
                context.watch<DataController>().getSObjectDropDownList.map((data) {
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
