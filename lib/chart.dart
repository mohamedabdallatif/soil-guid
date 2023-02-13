
import 'package:flutter/material.dart';
import 'BackgroundCollectingTask.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});
  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);
  List<FlSpot> list1=List<FlSpot>.empty(growable: true);
  for (var element in task.samples) {
    list1.add(FlSpot(element.hum, element.moisture));
  }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart Page'),
        actions: [
            (task.inProgress
                ? IconButton(icon: const Icon(Icons.pause), onPressed: task.pause)
                : IconButton(
                    icon: const Icon(Icons.play_arrow), onPressed: task.reasume))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 12.0, 8),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
            minX: 0,
            maxX: 100,
            minY: 0,
            maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots:list1 ,
                  isCurved: true,
                ),
              ],
            ),
            
        ),
      )
        );
  }
}