import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/degreeWidget/graphData.dart';

//questa è la classe che costruisce il grafico
class MyGraph extends StatelessWidget {
  //lista che contiene i voti
  final List<double> degreeList;
  //qui viene passato come parametro la lista con i voti da listpageconst
  MyGraph({super.key, required this.degreeList});

  @override
  Widget build(BuildContext context) {
    //creo un oggetto graphdata passando come parametro la lista di voti
    GraphData myGraphData = GraphData(voti: degreeList);
    //faccio il cast a tipo singleBar
    myGraphData.initializeBarData();

    //ciò che viene visualizzato
    return BarChart(
      BarChartData(
          groupsSpace: 10,
          alignment: BarChartAlignment.start,
          maxY: 30,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barGroups: myGraphData.barData //la lista dopo il cast a singleBar
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(
                        toY: data.y,
                        color: Colors.grey[600],
                        width: 20,
                        borderRadius: BorderRadius.circular(3),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 30,
                          color: Colors.grey[200],
                        )),
                    BarChartRodData(toY: 0),
                  ]))
              .toList()),
    );
  }
}
