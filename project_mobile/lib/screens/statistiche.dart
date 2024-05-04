import 'package:flutter/material.dart';
import 'package:project_mobile/preferences/exam_pref.dart';
import 'package:project_mobile/widget/ExamItem.dart';
import 'package:project_mobile/widget/NavBar.dart';
import 'package:project_mobile/widget/statswidget/bar/bargraph.dart';
import 'package:project_mobile/widget/statswidget/pie/piegraph.dart';

class Statistiche extends StatefulWidget {
  @override
  _StatisticheState createState() => _StatisticheState();
}

class _StatisticheState extends State<Statistiche> {
  late List<ExamItem> voti; //qui metto ciò che è salvato su locale

  @override
  void initState() {
    super.initState(); // su voti ho la lista degli esami salvati su locale
    this.voti = ExamPreferences.getListItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("statistiche"),
      ),
      drawer: NavBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          //grafico con le barre,
          MyBarChart(exams: voti),
          //grafico a torta,
          MyPieChart(),
          //media e roba varia
        ],
      )),
    );
  }
}
