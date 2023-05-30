import 'package:flutter/material.dart';

class TabularResponse extends StatelessWidget {
  TabularResponse({super.key, required this.response});

  List response;
  List<TableRow> tableRow = [];

  @override
  Widget build(BuildContext context) {
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

    return Table(
      columnWidths: const {
        0: FixedColumnWidth(80.0),
        1: FlexColumnWidth(1.0),
      },
      children: tableRow,
    );
  }
}