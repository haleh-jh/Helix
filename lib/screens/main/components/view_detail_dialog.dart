import 'package:admin/common/custom_snackbar.dart';
import 'package:admin/common/file_downloader.dart';
import 'package:admin/common/http_client.dart';
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
import 'package:url_launcher/url_launcher.dart';

class ViewDetailDialog extends StatelessWidget {
  final ObservationsModel observation;
  ViewDetailDialog({
    Key? key,
    required this.c,
    required this.observation,
    required this.ObservationId,
  }) : super(key: key);

  final BuildContext c;
  String imgUrl = '';
  final String ObservationId;
  ValueNotifier<List<String>> downloadList = ValueNotifier([]);

  static StateSetter? stateSetter;

  @override
  Widget build(BuildContext context) {
    _getDowloadFiles(ObservationId, context);
    return StatefulBuilder(builder: (cc, state) {
      stateSetter = state;
      return Dialog(
          insetPadding: EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 4.h),
          backgroundColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
          child: SingleChildScrollView(
            child: Container(
                width: 100.w,
                padding: EdgeInsets.all(2.w),
                child: ValueListenableBuilder(
                  valueListenable: downloadList,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0.5.w)),
                              color: secondaryColor),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 1.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name:   ${observation.name}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      color: Color(0xff2697ff),
                                    ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: kDeleteIconColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(0.5.w)),
                          child: CachedNetworkImage(
                            imageUrl: imgUrl,
                            fit: BoxFit.cover,
                            height: 30.h,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  //  borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
                                  color: kPlaceholderColor),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  //  borderRadius: BorderRadius.all(Radius.circular(cardRadius)),
                                  color: kPlaceholderColor),
                            ),
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
                        ListView.builder(
                          itemCount: downloadList.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.attach_file,
                                    color: Color(0xff2697ff),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      String fileName =
                                          downloadList.value[index];

                                      String url =
                                          "${BaseUrl}UploadedFiles/${ObservationId}/$fileName";

                                      launchUrl(Uri.parse(url));
                                    },
                                    child: Text(
                                      downloadList.value[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 4.sp,
                                            color: Color(0xff2697ff),
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.dashed,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    );
                  },
                )),
          ));
    });
  }

  void _getDowloadFiles(String id, BuildContext context) async {
    try {
      var mProvider = Provider.of<DataController>(context);
      List<String> list = await mProvider.getDownloadFile(id);
      print("list: ${list.length > 0}");
      if (list.length > 0) {
        String fileName = list[0].replaceFirst('.fits', '');
        imgUrl = "${BaseUrl}UploadedFiles/$id/thumb/${fileName}.jpeg";
        print("imgUrl: $imgUrl");
        downloadList.value = list;
      }
    } catch (e) {}
  }

  void _downloadFile() {}
}
