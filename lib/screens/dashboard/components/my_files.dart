import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles(
      {Key? key,
      this.telescopesCount = 0,
      this.detectorsCount = 0,
      this.objectsCount = 0,
      this.framesCount = 0})
      : super(key: key);

  final int telescopesCount;
  final int detectorsCount;
  final int objectsCount;
  final int framesCount;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
              telescopesCount: telescopesCount,
              detectorsCount: detectorsCount,
              objectsCount: objectsCount,
              framesCount: framesCount),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              telescopesCount: telescopesCount,
              detectorsCount: detectorsCount,
              objectsCount: objectsCount,
              framesCount: framesCount),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView(
      {Key? key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      //----
      this.telescopesCount = 0,
      this.detectorsCount = 0,
      this.objectsCount = 0,
      this.framesCount = 0})
      : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  final int telescopesCount;
  final int detectorsCount;
  final int objectsCount;
  final int framesCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return getMyFiles(index);
      },
    );
  }

  FileInfoCard getMyFiles(int index) {
    switch (index) {
      case 0:
        {
          return FileInfoCard(
              info: CloudStorageInfo(
            title: "Telescopes",
            numOfFiles: 1328,
            svgSrc: "assets/icons/Documents.svg",
            totalStorage: "${this.telescopesCount}",
            color: primaryColor,
            percentage: 35,
          ));
        }
      case 1:
        {
          return FileInfoCard(
              info: CloudStorageInfo(
            title: "Detectors",
            numOfFiles: 1328,
            svgSrc: "assets/icons/google_drive.svg",
            totalStorage: "${this.detectorsCount}",
            color: Color(0xFFFFA113),
            percentage: 35,
          ));
        }
      case 2:
        {
          return FileInfoCard(
              info: CloudStorageInfo(
            title: "Objects",
            numOfFiles: 1328,
            svgSrc: "assets/icons/one_drive.svg",
            totalStorage: "${this.objectsCount}",
            color: Color(0xFFA4CDFF),
            percentage: 10,
          ));
        }
      case 3:
        {
          return FileInfoCard(
              info: CloudStorageInfo(
            title: "Frames",
            numOfFiles: 5328,
            svgSrc: "assets/icons/drop_box.svg",
            totalStorage: "${this.framesCount}",
            color: Color(0xFF007EE5),
            percentage: 78,
          ));
        }
      default:
        {
          return FileInfoCard(
              info: CloudStorageInfo(
            title: "--",
            numOfFiles: 5328,
            svgSrc: "assets/icons/drop_box.svg",
            totalStorage: "${this.framesCount}",
            color: Color(0xFF007EE5),
            percentage: 78,
          ));
        }
    }
  }
}
