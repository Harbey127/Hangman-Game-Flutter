import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../widgets/result_score.dart';

class ScoreScreen extends StatelessWidget {
  final dynamic query;

  const ScoreScreen({Key? key, required this.query}) : super(key: key);

  List<TableRow> createRow(var query, BuildContext context) {
    query.sort((a, b) => b.toString().compareTo(a.toString()));
    List<TableRow> rows = [];
    final theme = Theme.of(context).textTheme.headline2;
    rows.add(
      const TableRow(
        children: [
          ResultScore(text: 'Rank'),
          ResultScore(text: 'Date'),
          ResultScore(text: 'Score'),
        ],
      ),
    );
    int numOfRows = query.length;
    List<String> topRanks = ["🥇", "🥈", "🥉"];
    for (var i = 0; i < numOfRows && i < 10; i++) {
      var row = query[i].toString().split(",");
      var date = row[1].split(" ")[0].split("-");
      var scoreDate = formatDate(
          DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2])),
          [yy, '-', M, '-', d]);

      Widget item = TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            i < 3 ? topRanks[i] + '${i + 1}' : '${i + 1}',
            style: theme,
            textAlign: TextAlign.center,
          ),
        ),
      );
      Widget item1 = TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              scoreDate,
              style: theme,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
      Widget item2 = TableCell(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            row[0],
            style: theme,
            textAlign: TextAlign.center,
          ),
        ),
      );
      rows.add(
        TableRow(
          children: [item, item1, item2],
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: query.length == 0
            ? const Center(
                child: Text(
                  "No Scores Yet!",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Center(
                        child: Container(
                          margin:
                              const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 15.0),
                          child: const Text(
                            'High Scores',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        textBaseline: TextBaseline.alphabetic,
                        children: createRow(query, context),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
