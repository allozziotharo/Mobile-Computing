import 'package:project_mobile/widget/degreeGraph/singleBar.dart';

//classe che contiene i dati del grafico
class GraphData {
  //lista che contiente tutti i voti attuali
  List<double> voti;

  //costruttore
  GraphData({required this.voti});

  //lista per fare il cast da double a tipo singleBar
  List<singleBar> barData = [];

  //ogni elemento della lista voti diventa -> singleBar
  void initializeBarData() {
    for (int i = 0; i < voti.length; i++) {
      barData.add(singleBar(x: i, y: voti[i]));
    }
  }
}
