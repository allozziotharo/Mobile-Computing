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
      decoration: BoxDecoration(
        color: Colors.blue[600],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text(day,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
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
  Widget BuildItem(BuildContext context) => Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x33000000),
                      offset: Offset(
                        0,
                        1,
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: Text(item.subject,
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF14181B),
                                  fontSize: 30,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0x4DEE8B60),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 4, 8, 4),
                                      child: Text(item.start,
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFFEE8B60),
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 8, 0),
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0x4DEE8B60),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 4, 8, 4),
                                      child: Text(item.end,
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFFEE8B60),
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      //le note
                      Container(
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(0xFFE0E3E7),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(item.notes,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                      Container(
                        //da cambiare con la checkBox
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(0xFFE0E3E7),
                            width: 1,
                          ),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 32,
                          ),
                          onPressed:
                              onClicked, //richiamerà removeItem nella classe weekPageState
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
