import 'package:admin/controllers/ListDataController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelescopeDropDown extends StatelessWidget {
  final Function(dynamic) onChange;
  const TelescopeDropDown({
    Key? key,
    required this.title,
    required this.onChange,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    context.read<ListDataController>().telescopeSetSValue(context.read<ListDataController>().telescopelist.length > 0? 
    context.read<ListDataController>().telescopeValue : '');
    return DropdownButton(
      hint: Text(title), // Not necessary for Option 1
      value: context.watch<ListDataController>().telescopeValue,
      isExpanded: true,
      onChanged: (v) {
        print("v: ${v}");
        context.read<ListDataController>().telescopeSetSValue(v.toString());
        onChange(v);
      },
      items: context.watch<ListDataController>().telescopelist.map((value) {
        return DropdownMenuItem(
          child: new Text(value.name),
          value: value.name,
        );
      }).toList(),
    );
  }
}
