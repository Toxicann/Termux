import 'package:flutter/material.dart';

class ExecResponse extends StatelessWidget {
  ExecResponse({super.key, required this.response});

  List<String> response;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListView.builder(
        itemCount: response.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Text(
          response[index],
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

// class RichExecResp extends StatelessWidget {
//   RichExecResp({super.key, required this.response});
//   List response;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: response.length,
//         itemBuilder: (context, index) {
//           List keys = response[index].keys.toList();

//           return RichText(
//             text: TextSpan(
//               text: response[index][keys[0]],
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: keys[0] == "command"
//                         ? Theme.of(context).colorScheme.secondary
//                         : Theme.of(context).primaryColor,
//                   ),
//               children: keys.length > 1
//                   ? [
//                       TextSpan(
//                         text: response[index][keys[1]],
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       )
//                     ]
//                   : [],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

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
