import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/ExamItem.dart';

class MyBarChart extends StatelessWidget {
  final List<ExamItem> exams;
  const MyBarChart({required this.exams, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups(exams),
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 30,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group, int groupIndex,
              BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(
                rod.toY.toString(),
                const TextStyle(
                    color: Colors.cyan, fontWeight: FontWeight.bold));
          }));

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = this.exams[value.toInt()].esame;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [Colors.blueAccent, Colors.redAccent],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> barGroups(List<ExamItem> exams) {
    return List.generate(
        exams.length,
        (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                    toY: exams[index].voto.toDouble(), gradient: _barsGradient)
              ],
              showingTooltipIndicators: [0],
            ));
  } /*[
        BarChartGroupData(
          x: 0,
          barRods: [BarChartRodData(toY: 8, gradient: _barsGradient)],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [BarChartRodData(toY: 10, gradient: _barsGradient)],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [BarChartRodData(toY: 15, gradient: _barsGradient)],
          showingTooltipIndicators: [0],
        ),
      ];*/
}
