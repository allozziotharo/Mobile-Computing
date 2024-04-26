/*USARE QUESTO FILE PER CARICAMENTO DEI DATI CHE VANNO NEL GRAFICO*/

import 'package:project_mobile/widget/ExamItem.dart';

class SectionData {
  //questa la uso per fare la lista finale

  String voto; //cosa viene stampato nella fetta
  double occorrenze; //quanto deve essere grande la fetta (0.0 -- 1.0)

  //costruttore
  SectionData({required this.voto, required this.occorrenze});
}

class PieData {
  //prendo la lista degli esami salvati su locale
  List<SectionData> getPieChartSection(List<ExamItem> exams) {
    List<SectionData> toReturn = []; //lista da restituire con SectionData
    //qui mapperò i voti e le loro occorrenze
    Map<String, double> voto2occorrenze = {};
    //questo mi serve poi per normalizzare
    int totale = 0;
    //con questo ciclo conto le occorrenze di ogni voto e le metto in una mappa
    for (var exam in exams) {
      totale = totale + 1;
      if (voto2occorrenze.containsKey(exam.voto.toString())) {
        //se già ho incontrato quel voto
        voto2occorrenze[exam.voto.toString()] =
            voto2occorrenze[exam.voto.toString()]! + 1.0;
      } else {
        voto2occorrenze[exam.voto.toString()] = 1.0;
      }
    }
    //alla fine di questo ciclo voto2occorrenze contiene voto -> n° occorrenze del voto

    for (var key in voto2occorrenze.keys) {
      //scorro le chiavi e aggiungo alla lista SectionData
      toReturn.add(SectionData(
          voto: key,
          occorrenze: occorrenzaNormalizzata(voto2occorrenze[key]!, totale)));
    }

    return toReturn;
  }

  double occorrenzaNormalizzata(double daNormalizzare, int totale) {
    return daNormalizzare / totale;
  }

  /*SISTEMARE QUESTO CODICE FUNZIONA MA FA VOMITARE*/

  //dentro value ci deve essere un valore compreso tra 0.0 e 1.0
  //quindi devo normalizzare i valori
}
