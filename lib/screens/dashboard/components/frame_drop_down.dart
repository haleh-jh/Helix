import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/ListDataController.dart';
import 'package:admin/data/models/frames.dart';
import 'package:admin/data/models/general_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FrameDropDown extends StatelessWidget {
final ValueNotifier<GeneralModel?> frameValue;
  const FrameDropDown({
    Key? key,
    required this.title, required this.frameValue,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
      return ValueListenableBuilder(
        valueListenable: frameValue,
        builder: (context, value, child) {
          return DropdownButton<GeneralModel>(
            hint: Text(title),
            value: frameValue.value,
            isExpanded: true,
            onChanged: (newValue) {
              frameValue.value = newValue;
            },
            items:
                context.watch<DataController>().getFrameDropDownList.map((data) {
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

