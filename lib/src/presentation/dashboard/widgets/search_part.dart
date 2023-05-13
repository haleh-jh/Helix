import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:helix_with_clean_architecture/src/data/models/observation.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/table_label.dart';
import 'package:helix_with_clean_architecture/src/presentation/components/view_detail_dialog.dart';
import '../../../core/utils/constants/sizes.dart';

class SearchPart extends StatelessWidget {
  final List<ObservationsModel> observations;
  const SearchPart({
    Key? key, required this.observations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 400,
              columns: SearchObservationDataTable(),
              rows: ObservationDataRow(observations.length,
                  observations, context, () {}, () {}, (fileinfo) {
                onPressedViewButton(context, fileinfo);
              }, true)),
        ),
      ],
    );
  }

  onPressedViewButton(BuildContext c, var data) async {
 //   final listDataController = Provider.of<DataController>(c, listen: false);
    await showDialog(
        context: c,
        builder: (_) {
          return ViewDetailDialog(
                c: c,
                observation: data,
                ObservationId: data.id,
              );
              // checkkk
          // ListenableProvider<DataController>.value(
          //     value: listDataController,
          //     child: ViewDetailDialog(
          //       c: c,
          //       observation: data,
          //       ObservationId: data.id,
          //     ));
        });
  }
}
