//materiale standard
import 'package:flutter/material.dart';
//import per usare route

/*widget che va nella row di weekpage*/
class DayItemWidget extends StatelessWidget {
  final String day; //giorno da visualizzare
  //costruttore
  const DayItemWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 160,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.blueGrey[600]),
      child: Center(
        child: Text(day, style: TextStyle(fontSize: 30, color: Colors.white)),
      ),
    );
  }
}

//questa classe contiene i dati per il widget della lista di lezioni di weekpage
class ClassItem {
  //nome del giorno
  String subject;
  String notes;
  String start;
  String end;

  //costruttore
  ClassItem(
      {required this.subject,
      required this.notes,
      required this.start,
      required this.end});

  ClassItem.fromMap(Map<String, dynamic> map) //costruttore json -> per encoding
      : subject = map['subject'],
        notes = map['notes'],
        start = map['start'],
        end = map['end'];

  Map<String, dynamic> toMap() {
    //restituisce i valori salvati con json
    return {
      'subject': subject,
      'notes': notes,
      'start': start,
      'end': end,
    };
  }
}

//classe del singolo widget che viene visualizzato nella lista
class ClassItemWidget extends StatelessWidget {
  //attributi del widget visualizzato
  final ClassItem item; //riferimento alla lezione
  final Animation<double> animation; //animazione
  final VoidCallback? onClicked; //funzione che serve all'icona cestino

  //costruttore
  const ClassItemWidget({
    required this.item,
    required this.animation,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  //restituisce una SizeTransition per l'animazione (?) con figlio il widget che vogliamo far visualizzare restituito da BuildItem()
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: BuildItem(context),
    );
  }

  //funzione che costruisce il widget da visualizzare vero
  Widget BuildItem(BuildContext context) => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors
                .amber //eventualmente implementare un modo per far scegliere all'utente il colore
            ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${item.subject}",
                  style: TextStyle(
                      fontSize:
                          16)), //se qui aumento la size errore di overflow
              Text("${item.start}", style: TextStyle(fontSize: 14)),
              Text("${item.end}", style: TextStyle(fontSize: 14)),
            ],
          ),
          title: Center(
            child: Text("${item.notes}", style: TextStyle(fontSize: 16)),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 32,
            ),
            onPressed:
                onClicked, //richiamerà removeItem nella classe weekPageState
          ),
        ),
      );
}
