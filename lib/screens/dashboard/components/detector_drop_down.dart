import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetectorDropDown extends StatelessWidget {
final ValueNotifier<GeneralModel?> detectorValue;
 DetectorDropDown({
    Key? key,
    required this.title, required this.detectorValue,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: detectorValue,
        builder: (context, value, child) {
          return DropdownButton<GeneralModel>(
            hint: Text(title),
            value: detectorValue.value,
            isExpanded: true,
            onChanged: (newValue) {
              detectorValue.value = newValue;
            },
            items:
                context.watch<DataController>().getDetectorDropDownList.map((data) {
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
