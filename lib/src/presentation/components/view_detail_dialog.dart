
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/colors.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/http_client.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/injector.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/observation_detail_card.dart';
import 'package:helix_with_clean_architecture/src/presentation/dashboard/cubit/view_detail_cubit.dart';
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
  final String ObservationId;
  static StateSetter? stateSetter;
  final ViewDetailCubit bloc= injector<ViewDetailCubit>();

  @override
  Widget build(BuildContext context) {
    bloc.getDownloadedFile(ObservationId);
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
                  valueListenable: bloc.downloadList,
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
                                "Name: ${observation.name}",
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
                                child: const Icon(
                                  Icons.close,
                                  color: kDeleteIconColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(0.5.w)),
                          child: CachedNetworkImage(
                            imageUrl: bloc.imgUrl,
                            fit: BoxFit.cover,
                            height: 30.h,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: kPlaceholderColor),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 30.h,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: kPlaceholderColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        ObservationDetailCard(
                          observation: observation,
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                        ListView.builder(
                          itemCount: bloc.downloadList.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.attach_file,
                                    color: Color(0xff2697ff),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      String fileName =
                                          bloc.downloadList.value[index];

                                      String url =
                                          "${BaseUrl}UploadedFiles/${ObservationId}/$fileName";

                                      launchUrl(Uri.parse(url));
                                    },
                                    child: Text(
                                      bloc.downloadList.value[index],
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

  void _downloadFile() {}
}
