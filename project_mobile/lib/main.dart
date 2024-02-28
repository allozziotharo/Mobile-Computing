//import del materiale standard
import 'package:flutter/material.dart';
//
import 'constants/costantiGUI.dart';
import 'constants/Fonts.dart';
import 'hierarchy/Section.dart'; //duplicato ma ntoccamo niente per ora
import 'package:project_mobile/hierarchy/Section.dart';
//import delle varie pagine
import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/loginpage.dart';
import 'package:project_mobile/screens/settingspage.dart';
//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomeScreen(),
      //home: HomePage(),
      onGenerateRoute: route.controller, //crea il controller nel file route
      initialRoute:
          route.signupPage, //la prima pagina visualizzaa è quella di login
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Section> sections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select a sphere of your life you want to manage, or create a new one',
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Color(costantiGUI.primaryColor),
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < sections.length; i++)
            SectionWidget(
              section: sections[i],
              onTap: () {
                // Implementa la logica per toccare una sezione esistente, se necessario
              },
              onLongPress: () {
                _showSectionContextMenu(sections[i]);
              },
            ),
          AddSectionButton(
            onTap: () {
              _showAddSectionDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showAddSectionDialog(BuildContext context) async {
    String newSectionTitle = '';

    Section? nuovaSezione = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Inserisci il Titolo della Nuova Sezione'),
          content: TextField(
            onChanged: (value) {
              newSectionTitle = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ANNULLA'),
            ),
            TextButton(
              onPressed: () {
                if (newSectionTitle.isNotEmpty) {
                  Section nuovaSezione = Section(titolo: newSectionTitle);
                  nuovaSezione.aggiungiSezione(context, newSectionTitle);
                  Navigator.of(context).pop(nuovaSezione);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (nuovaSezione != null) {
      setState(() {
        sections.add(nuovaSezione);
      });
    }
  }

  void _showSectionContextMenu(Section section) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Scegli cosa fare'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Rinomina Sezione'),
                onTap: () {
                  Navigator.of(context)
                      .pop(); // Chiudi la finestra di dialogo corrente
                  _showRenameSectionDialog(section);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Elimina Sezione'),
                onTap: () {
                  Navigator.of(context)
                      .pop(); // Chiudi la finestra di dialogo corrente
                  _showDeleteSectionDialog(section);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRenameSectionDialog(Section section) async {
    String newSectionTitle = section.titolo;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Rinomina Sezione'),
          content: TextField(
            onChanged: (value) {
              newSectionTitle = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ANNULLA'),
            ),
            TextButton(
              onPressed: () {
                if (newSectionTitle.isNotEmpty) {
                  setState(() {
                    sections.remove(section);
                    sections.add(Section(titolo: newSectionTitle));
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteSectionDialog(Section section) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Eliminare permanentemente la sezione e tutte le informazioni al suo interno?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  sections.remove(section);
                });
                Navigator.of(context).pop();
              },
              child: Text('Si'),
            ),
          ],
        );
      },
    );
  }
}

class SectionWidget extends StatelessWidget {
  final Section section;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  SectionWidget(
      {required this.section, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), //RAGGIO DEL BORDO
          border: Border.all(
              color: Color(costantiGUI.secondaryColor), width: 2.0), //CONTORNO
        ),
        child: Text(
          section.titolo,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black, //COLORE TITOLO SEZIONI
            fontFamily: 'RussoOne',
          ),
          textAlign: TextAlign.center, //TITOLO SEZIONI CENTRATO
        ),
      ),
    );
  }
}

class AddSectionButton extends StatelessWidget {
  final VoidCallback onTap;

  AddSectionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.0,
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(costantiGUI.secondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          '+',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }
}
