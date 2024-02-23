//materiale standard
import 'package:flutter/material.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;


//schermata di Login bisogna finire la parte dei bottoni, e migliorarlo esteticamente
class LoginPage extends StatelessWidget {
  const LoginPage ({super.key});

  @override
  Widget build(BuildContext context){
    //qui posso definire dei layout più complessi che richiamerò in return scaffold
    
    //definisco il widget titleSection  (non è allineato con le caselle di testo e il text in fondo)
    Widget titleSection = Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: [
          Icon(   //1° figlio sarà l'icona (primo el a sx)
            Icons.star ,
            color: Colors.red[500],
          ),
          const Text('AppTitle'), //poi ci sarà il titolo dell' app a dx
        ],
      ),
    );

    //definisco il widget loginSection   (non si vede il bordo intorno ai textfield a meno che non ci clicchi sopra)
    Widget loginSection = Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [   //questa colonna avrà due figli la casella di testo per l'email e per la password
          SizedBox(
          width: 150,
          child: TextField(   //textfield per l'email 
            decoration : InputDecoration(
                  labelText : 'email',
                  focusedBorder: OutlineInputBorder(  //focusedBordered mi permette di modificare l'estetica dei bordi mentre la casella è selezionata
                    borderSide: BorderSide(
                      color: Colors.grey, // Colore del bordo
                      width: 3.0, // Spessore del bordo
                    ),
                  ),//per personalizzare qui i bordi mentre la casella non è selezionata dovrei aggiungere enabledBorder
                ),
            ),
          ),
          SizedBox(
          width: 150,
          child: TextField(  //textfield per la password
            obscureText: true,  //in questo modo compaiono i puntini invece dei caratteri
            decoration : InputDecoration(
                  labelText : 'password',
                  focusedBorder: OutlineInputBorder(  //focusedBordered mi permette di modificare l'estetica dei bordi mentre la casella è selezionata
                    borderSide: BorderSide(
                      color: Colors.grey, // Colore del bordo
                      width: 3.0, // Spessore del bordo
                    ),
                  ),//per personalizzare qui i bordi mentre la casella non è selezionata dovrei aggiungere enabledBorder
                ),
            ),
          ),
        ],
      ),
    );

    //definisco il widget per loginButton
    //aspettiamo di usare playfab
    
    
    //questo è il layout che verrà restituito
    return Scaffold (
      appBar: AppBar(
        title: const Text ('login Screen'),
      ),
      body: Column(
        children: [
          titleSection,
          loginSection,
          //devo aggiungere i bottoni 
          Text ('bla bla bla bla'),
          ElevatedButton(
            child: Text('home', style: TextStyle(color: Colors.white),),
            onPressed: () => Navigator.pushNamed(context, route.homePage),
          ),
        ],
      ),
    );
  }
}

