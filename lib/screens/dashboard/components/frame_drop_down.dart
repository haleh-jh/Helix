import 'package:admin/controllers/ListDataController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrameDropDown extends StatelessWidget {
  final Function(dynamic) onChange;

  const FrameDropDown({
    Key? key,
    required this.title,
    required this.onChange,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text(title), // Not necessary for Option 1
      value: context.read<ListDataController>().framelist.length > 0
          ? context.read<ListDataController>().framelist[0]
          : '',
      isExpanded: true,
      onChanged: onChange,
      items: context.watch<ListDataController>().framelist.map((value) {
        return DropdownMenuItem(
          child: new Text(value.name),
          value: value,
        );
      }).toList(),
    );
  }
}
