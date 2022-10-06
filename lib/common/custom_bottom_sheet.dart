import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet{

  static customBottomSheet(BuildContext context, Widget widget){
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.90,
                child: Container(
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: widget));
          });
        });
 
  }
}

