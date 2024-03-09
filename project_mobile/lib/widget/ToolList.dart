//materiale standard
import 'package:flutter/material.dart';


//WIDGET CHE VISUALIZZA L'ANTEPRIMA DE NA SEZIONE
/*corrisponde, nelle foto delle schermate su OneNote,
a come sono visualizzate "sessione" e "carriera"
una volta toccato su HOME->UNIVERSITA
UTILIZZO PENSATO:
Container da mostrare secondo me solo a profondità 1, fornendo un'anteprima della relativa profondità 2
(profondità 0 per me sono le sezioni nella HOME),

vorrei che le sezioni di profondità maggiore (quando siamo in prof >= 2, invece),
vengano mostrare solo come quadratini senza anteprima
*/


//WIDGET CHE VISUALIZZA LA LISTA DE TOOL AGGIUNTI DALL'UTENTE DENTRO NA SEZIONE
Widget listaTool = ListView(
  padding: EdgeInsets.all(2),
  children: <Widget> [
    voceTool,
  ]
);





//WIDGET CHE RAPPRESENTA LA SINGOLA VOCE DELLA LISTA DI WIDGET tool
/* praticamente qua sotto CHILDREN della LIST VIEW di sopra*/
Widget voceTool = Column(  //colonna NON si scorre (bona pe mostralli insieme)
        children: <Widget> [
//primo widget
        Text(
          "Titolo specifico fornito da utente",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                //    backgroundColor: Color.fromARGB(114, 0, 85, 255),
                    ),
                  textAlign: TextAlign.left,
                ), 


//secondo widget
        Container(
            
          padding: EdgeInsets.all(50.0),
          //constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(210, 163, 194, 255),
            border: Border.all( //da lo stesso bordo a qualsiasi grandezza di container
              color: Color.fromARGB(114, 0, 85, 255),
              width: 3,
              style: BorderStyle.solid
            ),  
          borderRadius: BorderRadius.all(Radius.circular(17.5)),
          boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(194, 6, 0, 97),
                    blurRadius: 4.0,
                    spreadRadius: 2.0,
                  )
          ]  
          ),
          ),
     ],  

);