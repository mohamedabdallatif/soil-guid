import 'package:flutter/material.dart';
import 'package:humidity_detector/BackgroundCollectingTask.dart';
class TablePage extends StatefulWidget {
  const TablePage({super.key});
  @override
  State<TablePage> createState() => _TablePageState();
}
class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);
        List<TableRow> list2=[
            TableRow(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 10,
                  child: const Text('Humidity'),
                ),
                 Container(
                  padding: const EdgeInsets.all(10),
                  width: 10,
                  child: const Text('Moisture'),
                ),
              ]
            ),
        ];
        for (var element in task.samples) {
    list2.add(TableRow(
      children:[
        Container(
          padding: const EdgeInsets.all(10),
          width: 10,
          child: Text('${element.hum}'),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: 10,
          child: Text('${element.moisture}'),
        )
        ]
        ));
  }
    return 
       Scaffold(
        appBar: AppBar(title: const Text('Table')
        ),
        body: SingleChildScrollView(
          child: Table(
            border: TableBorder.all(),
            children:list2
          ),
        ),
      );

  }
}