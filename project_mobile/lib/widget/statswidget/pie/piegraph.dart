//import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/preferences/exam_pref.dart';
import 'package:project_mobile/widget/statswidget/pie/pie_data.dart';

/*DEFINISCO IL GRAFICO*/
class MyPieChart extends StatefulWidget {
  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: PieChart(
          swapAnimationDuration: const Duration(milliseconds: 200),
          swapAnimationCurve: Curves.linear,
          PieChartData(
            pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            }),
            sectionsSpace: 2,
            centerSpaceRadius: 0,
            sections: pieChartSection(),
          )),
    );
  }

  List<PieChartSectionData> pieChartSection() {
    //elementi su cui fare il cast from SectionData -> PieChartSectionData
    List<SectionData> toCast = //SectionData {String voto, double occorrenze}
        PieData().getPieChartSection(ExamPreferences.getListItem());

    return List.generate(toCast.length, (index) {
      /*qui definisco variabili che valgono per ogni elemento*/

      final isTouched = index == touchedIndex;
      final radius = isTouched ? 150.0 : 100.0;
      final fontSize = isTouched ? 24.0 : 16.0;

      /**********************/

      //quello che viene aggiunto nella lista
      return PieChartSectionData(
          //color: ,
          value: toCast[index].occorrenze,
          title: toCast[index].voto,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ));
    });
  }
}
