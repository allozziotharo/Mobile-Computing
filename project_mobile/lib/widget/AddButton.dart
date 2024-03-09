//materiale standard
import 'package:flutter/material.dart';

Widget addButton = FloatingActionButton.extended(
  
    backgroundColor: Color.fromARGB(210, 163, 194, 255),
    onPressed:(){
      //displayToolPool(); //VA SCRITTA, E' LA FUNZIONE CHE MOSTRA IL MENU CHE VOGLIAMO NOI
    },
    label: Text("Aggiungi Funzionalità"),
    icon: const Icon(Icons.add),

);