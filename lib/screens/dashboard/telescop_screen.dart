import 'package:admin/common/custom_text_field.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class TelescopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            primary: false,
            padding: EdgeInsets.all(defaultPadding),
            child: TelescopWidget(),
          ),
      ),
    );
  }
}

class TelescopWidget extends StatelessWidget {
  const TelescopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        SizedBox(height: defaultPadding),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical:
                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: (){
                    onPressedButton(context);
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
              ],
            ),
          ],
        ),
                  SizedBox(height: defaultPadding),
                  RecentFiles(),
                  // if (Responsive.isMobile(context))
                  //   SizedBox(height: defaultPadding),
                  if (Responsive.isMobile(context)) StarageDetails(),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  onPressedButton(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(builder: (context, state) {
              return Container(
                color: Color(0xFF737373),
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.w),
                            topLeft: Radius.circular(8.w))),
                    child: Column(
                      children: [
                         SearchField()
                      ],
                    )
                        ),
              );
            }),
          );
        });
  }
}
