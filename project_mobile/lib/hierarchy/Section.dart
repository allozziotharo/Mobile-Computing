import 'package:project_mobile/hierarchy/toolpool/PoolFunzionalita.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
class Section implements PoolFunzionalita {

    String titolo;
    DateTime? data;    //IL PUNTO INTERROGATIVO SIGNIFICA CHE IL CAMPO PUO ANCHE ESSERE NULL
    List <Section> sezioniFiglie;
    List <PoolFunzionalita> toolImplementati;  //in Dart non ci sono wildcard: in Java avrei dovuto scrive <? extends PoolFunzionalita>
    Section? sezionePadre;

    Section({required this.titolo, this.data}) : sezioniFiglie = [], toolImplementati = [];

    String get getTitolo => this.titolo;

    List <Section> getSezioniFiglie() {
        return this.sezioniFiglie;
    }

    List <PoolFunzionalita> getToolImplementati() {
        return this.toolImplementati;
    }

    void setSezionePadre(Section padre) {
      this.sezionePadre = padre;
    }
 

    
    @override
    Future<Section?> aggiungiSezione(BuildContext context, String titolo) async {
    /*
La sintassi Future<Section?> indica che il metodo aggiungiSezione restituirà un oggetto Future di tipo Section?.
Vediamo cosa significa ciascuna parte:

Future: Un Future rappresenta un valore o un errore che potrebbe non essere disponibile immediatamente.
    È utilizzato per gestire operazioni asincrone, come la lettura di dati da un file o una chiamata di rete,
    in cui il risultato potrebbe richiedere del tempo per essere ottenuto.

<Section?>: Questa è la tipizzazione generica del Future.
    Indica che il valore restituito dal Future sarà di tipo Section?.
    Il punto interrogativo (?) dopo Section indica che il tipo può essere nullable, cioè il valore può essere null.

Quindi, Future<Section?> indica un futuro risultato di tipo Section?, indicando che il risultato potrebbe essere un oggetto Section o null.
    */
    print("inizio aggiungiSezione");

    try {
        String nuovoTitolo = '';
        
        showDialog(
            context: context,
            builder: (context) {
            

            return AlertDialog(
                title: Text('Inserisci il titolo della nuova sezione'),
                content: TextField(
                onChanged: (value) {
                    nuovoTitolo = value;
                    },
                ),
                actions: [
                TextButton(
                    onPressed: () {
                    Navigator.of(context).pop();
                    },
                    child: Text('ANNULLA'),
                ),
                TextButton(
                    onPressed: () async {
                        print("premuto OK");
                        if (nuovoTitolo.isNotEmpty) {
                            print("titolo non vuoto");

                            print("creazione nuova sezione");
                            Section nuovaSezione = Section(titolo: nuovoTitolo);
                            nuovaSezione.setSezionePadre(this);

                            print("aggiunta della sezione alle sezioni figlie");
                            print("sezioniFiglie prima dell'aggiunta: $sezioniFiglie");
                            //sezioniFiglie ??= []; //Gli operatori ?? sono utilizzati per fornire un valore di fallback nel caso in cui il valore a sinistra sia null
                            //ho commentato la riga sopra perché ho cambiato il costruttore
                            sezioniFiglie.add(nuovaSezione); //L'operatore ! è utilizzato per indicare al compilatore che una variabile non sarà mai nulla.
                            print("sezioniFiglie dopo l'aggiunta: $sezioniFiglie");

                            Navigator.of(context).pop(nuovaSezione);
                            } else {
                                print("titolo vuoto");
                            }
                        },
                        child: Text('OK'),
                    ),
                ],
            );
            },
        );
        print("fine aggiungiSezione");
    } catch (e, stackTrace) {
        print("errore in aggiungiSezione: $e");
        print("Stack Trace: $stackTrace");
        return null;
        }
    }


void rimuoviSezione(Section toremove) {
  if(sezioniFiglie != null) this.sezioniFiglie.remove(toremove);
}




void _showAddSectionDialog(/*BuildContext context*/) async {
    String newSectionTitle = '';

    /*Section? nuovaSezione;*/
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Inserisci il titolo della nuova sezione'),
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
              onPressed: () async {
                print("premuto OK");
                if (newSectionTitle.isNotEmpty) {
                  print("titolo non vuoto");
                  Section nuovaSezione = this.aggiungiSezione(context, newSectionTitle);
                  if (nuovaSezione != null) {
                    print("sezione aggiunta");
                    setState(() {
                    sezioniFiglie.add(nuovaSezione); //serve ad aggiornare la lista e l'interfaccia utente
                    });
                  Navigator.of(context).pop(/*nuovaSezione*/);
                  } else {
                  print("errore nell'aggiunta della sezione");
                } 
              } else {
                  print("titolo vuoto");
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSectionContextMenu(/*Section section*/) { //commentato perche prima era nel main, ora  fa parte della classe Section stessa

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
                  Navigator.of(context).pop(); // Chiudi la finestra di dialogo corrente
                  _showRenameSectionDialog(/*section*/);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Elimina Sezione'),
                onTap: () {
                  Navigator.of(context).pop(); // Chiudi la finestra di dialogo corrente
                  _showDeleteSectionDialog(/*section*/);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRenameSectionDialog(/*Section section*/) async {
    String newSectionTitle = '';

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
                  /*setState(() {
                    sezioniFiglie.remove(section);
                    sezioniFiglie.add(Section(titolo: newSectionTitle));  //adesso l'invocazione di una funzione dentro una sezione agisce sulle funzioni figlie
                  });*/
                  setState(() {
                   titolo = newSectionTitle;
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

  void _showDeleteSectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminare permanentemente la sezione e tutte le informazioni al suo interno?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                /*setState(() {
                  sezioniFiglie.remove(this);
                });*/
                sezionePadre?.rimuoviSezione(this);
                Navigator.of(context).pop();
              },
              child: Text('Si'),
            ),
          ],
        );
      },
    );
  }

    //poi bisogna fare un override di ogni funzione presente nell'interfaccia, PER IMPLEMENTARNE IL CORPO QUI
}

class SectionWidget extends StatefulWidget {
  final Section section;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  SectionWidget({required this.section, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration (
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), //RAGGIO DEL BORDO
          border: Border.all(color: Color(costantiGUI.secondaryColor), width: 2.0), //CONTORNO
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