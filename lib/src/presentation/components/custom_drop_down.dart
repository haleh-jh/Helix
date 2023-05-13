import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/data/models/data_model.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:provider/provider.dart';

class CustomDropDown extends StatelessWidget {
  final ValueNotifier<DataModel?> valueNotifier;
  final List<DataModel> list;
  CustomDropDown({
    Key? key,
    required this.title, required this.valueNotifier, required this.list,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return DropdownButton<DataModel>(
            hint: Text(title),
            value: valueNotifier.value,
            isExpanded: true,
            onChanged: (newValue) {
              print("chch: ${newValue!.value} ${newValue!.key}");
              valueNotifier.value = newValue;
            },
            items: list.map((data) {
              return DropdownMenuItem<DataModel>(
                value: data,
                child: Text(
                  data.value,
                ),
              );
            }).toList(),
          );
        });
 
  }
}
