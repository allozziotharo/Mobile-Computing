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
          Divider(thickness: 5),
          //grafico con le barre,
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.deepPurple.withOpacity(0.1),
              
            ),
            //padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Bar Chart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyBarChart(exams: voti),
              ],
            ),
          ),
          Divider(thickness: 5),
          //grafico a torta,
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.deepPurple.withOpacity(0.1),
              
            ),
            //padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Pie Chart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MyPieChart(),
              ],
            ),
          ),
          //media e roba varia
        ],
      )),
    );
  }
}
