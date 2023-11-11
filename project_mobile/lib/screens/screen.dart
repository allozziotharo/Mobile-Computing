import 'package:flutter/material.dart';


class nuovaPagina extends StatelessWidget {
  const nuovaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('ciao caro'),
            Container(
              width : 150.0,
              child : TextField(
                decoration : InputDecoration(
                  labelText : 'inserisci testo',
                  focusedBorder: OutlineInputBorder(  //focusedBordered mi permette di modificare l'estetica dei bordi mentre la casella è selezionata
                    borderSide: BorderSide(
                      color: Colors.purple, // Colore del bordo
                      width: 5.0, // Spessore del bordo
                    ),
                  ),//per personalizzare qui i bordi mentre la casella non è selezionata dovrei aggiungere enabledBorder
                ),
              ),
            ),
            ElevatedButton(
              child : Text ('Go back'),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

