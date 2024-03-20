//materiale standard
import 'package:flutter/material.dart';
//import per usare route

class ClassItem {
  //nome del giorno
  final String subject;
  final TimeOfDay start;
  final TimeOfDay end;

  //costruttore
  const ClassItem(
      {required this.subject, required this.start, required this.end});
}

//classe del singolo widget che viene visualizzato nella lista
class ClassItemWidget extends StatelessWidget {
  //attributi del widget visualizzato
  final ClassItem item; //riferimento al giorno
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
              .amber, //eventualmente implementare un modo per far scegliere all'utente il colore
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
              Text("${item.start.format(context)}",
                  style: TextStyle(fontSize: 14)),
              Text("${item.end.format(context)}",
                  style: TextStyle(fontSize: 14)),
            ],
          ),
          //title: -> qui ci va la parte per inserire delle note
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
