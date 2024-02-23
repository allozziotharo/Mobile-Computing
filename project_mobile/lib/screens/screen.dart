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

//schermata di Login bisogna finire la parte dei bottoni, e migliorarlo esteticamente
class loginScreen extends StatelessWidget {
  const loginScreen ({super.key});

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
        ],
      ),
    );
  }
}

//creo il widget NavBar menù laterale
class NavBar extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Drawer (
      child: ListView(
        //rimuovere il padding rende la sidebar più carina
        padding: EdgeInsets.zero,
        //
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Germano'),
            accountEmail: Text('fragermano@numberone.com'),
            currentAccountPicture: CircleAvatar(
             child: ClipOval(
               child: Image.asset(
                 'assets/prova.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),//la parte di clipOval credo si possa togliere e lasciare solo CircleAvatar
              ),
            ),//Circle avatar
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'
                ),
              ),
            ),
          ),//userheader

          //lista delle sezioni del menù laterale
          //IN EVIDENZA
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('In Evidenza'),
            onTap: () => null,
          ),
          //LINK
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Links'),
            onTap: () => null,
          ),
          //CALENDARIO
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Calendario'),
            onTap: () => null,
          ),
          //NOTIFICHE
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifiche'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '1', //ora metto uno per comodità qui bisogna aggiungere la logica per cui si aggiunge una notifica
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //divider aggiunge una linea di separazione
          Divider(),  
          //IMPOSTAZIONI
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Impostazioni'),
            onTap: () => null,
          ),
          Divider(),
          //LOGOUT
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => null,
          ),
          //fine lista
        ],
      ),
    );
  }
}


//screen che contiene un menu laterale a scomparsa
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      drawer: NavBar(),  //widget creato sopra -> menu laterale
      appBar: AppBar(
        title: Text('HomePage'),  //se metto text come child di center viene un po' sulla dx a causa dell'icona del menu
      ),
      body: Center(),
    );
  }
}