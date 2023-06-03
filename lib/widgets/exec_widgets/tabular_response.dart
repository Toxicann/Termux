import 'package:flutter/material.dart';

class TabularResponse extends StatelessWidget {
  TabularResponse({super.key, required this.response});

  List response;

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRow = [];
    for (var element in response) {
      tableRow.add(
        TableRow(
          children: [
            Text(
              element["command"],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Text(
              element["function"],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Table(
        columnWidths: const {
          0: FixedColumnWidth(135.0),
          1: FlexColumnWidth(1.0),
        },
        children: tableRow,
      ),
    );
  }
}
