import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/pref.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/DataController.dart';
import 'package:admin/controllers/progressController.dart';
import 'package:admin/data/models/data.dart';
import 'package:admin/data/models/filters.dart';
import 'package:admin/data/models/object.dart';
import 'package:admin/data/models/observation.dart';
import 'package:admin/data/repo/service_repository.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/observation_detail_card.dart';
import 'package:admin/screens/dashboard/components/telescope_custom_dialog.dart';
import 'package:admin/screens/login/components/input_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class ViewDetailDialog extends StatelessWidget {
  final ObservationsModel observation;
  ViewDetailDialog({
    Key? key,
    required this.formKey,
    required this.scaffoldKey,
    required this.c,
    required this.observation,
    required this.ObservationId,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext c;
  final String imgUrl = '';
  final String ObservationId;
  ValueNotifier<List<String>> downloadList = ValueNotifier([]);

  static StateSetter? stateSetter;

  @override
  Widget build(BuildContext context) {
    _getDowloadFiles(ObservationId, context);
    return StatefulBuilder(builder: (cc, state) {
      stateSetter = state;
      return Dialog(
          insetPadding: EdgeInsets.fromLTRB(10.w, 13.h, 10.w, 13.h),
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
          child: SingleChildScrollView(
            child: Container(
                width: 100.w,
                padding: EdgeInsets.all(2.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imgUrl,
                      placeholder: (context, url) => Container(
                        height: 20.w,
                        width: 20.w,
                        decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
                            color: kPlaceholderColor),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: kPlaceholderColor,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    ObservationDetailCard(
                      observation: observation,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                )),
          ));
    });
  }

  void _getDowloadFiles(String id, BuildContext context) async {
    try {
      var mProvider = Provider.of<DataController>(context);
      downloadList.value = await mProvider.getDownloadFile(id);
    } catch (e) {}
  }
}
