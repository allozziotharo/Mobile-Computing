import 'package:flutter/material.dart';

//in questo file c'è una nuova pagina senza senso ci si possono fare prove o cancellare il file

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

class menuScreen extends StatefulWidget{
  const menuScreen({super.key});

  @override
  State<menuScreen> createState() => _menuScreenState();
}

class _menuScreenState extends State<menuScreen>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('aggiungi caselle di testo'),
      ),
      body: Center(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          //aggiungere la funzione che deve eseguire quando premuto il button
          addTextField();
        },
        
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );


  }

  void addTextField(){

  }
}
