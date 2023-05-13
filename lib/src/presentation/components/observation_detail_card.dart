import 'package:flutter/material.dart';
import 'package:helix_with_clean_architecture/src/core/utils/constants/sizes.dart';
import 'package:helix_with_clean_architecture/src/core/utils/responsive.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/domain/entity/card_info.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/view_detail_info_card.dart';


class ObservationDetailCard extends StatelessWidget {
  final ObservationsModel observation;
  const ObservationDetailCard({
    Key? key,
    required this.observation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    print(_size.width);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "User:   ${observation.userName}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              "Date:   ${observation.dateTime}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            ob: observation,
            crossAxisCount: 2,
            childAspectRatio: _size.width < 650 && _size.width > 350
                ? 1.5
                : _size.width > 650
                    ? 2
                    : 1,
          ),
          tablet: FileInfoCardGridView(
            ob: observation,
          ),
          desktop: FileInfoCardGridView(
            ob: observation,
            crossAxisCount: 5,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.8,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  final ObservationsModel ob;
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.ob,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    print("mobile");
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
     // itemCount: demoObservationDetail.length,
      itemCount: ObservationDetailInfo.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding * 2,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => ViewDetailInfoCard(
        info: ObservationDetailInfo[index],
        index: index,
        observation: ob,
      ),
    );
  }
}
