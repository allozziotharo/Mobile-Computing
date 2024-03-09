<<<<<<< Updated upstream
import 'package:project_mobile/hierarchy/toolpool/PoolFunzionalita.dart';
import 'package:flutter/material.dart';
class Section implements PoolFunzionalita {

    String titolo;
    DateTime? data;    //IL PUNTO INTERROGATIVO SIGNIFICA CHE IL CAMPO PUO ANCHE ESSERE NULL
    List <Section>? sezioniFiglie;
    List <PoolFunzionalita>? toolImplementati;  //in Dart non ci sono wildcard: in Java avrei dovuto scrive <? extends PoolFunzionalita>


    Section({required this.titolo, this.data}) : sezioniFiglie = [];

    String get getTitolo => this.titolo;

    List <Section>? getSezioniFiglie() {
        return this.sezioniFiglie;
    }

    List <PoolFunzionalita>? getToolImplementati() {
        return this.toolImplementati;
    }

 

    
    @override
    Future<Section?> aggiungiSezione(BuildContext context, String titolo) async {
=======
import 'package:project_mobile/hierarchy/toolpool/Tool.dart';
import 'package:flutter/material.dart';

class Section implements PoolFunzionalita {
  String titolo;
  DateTime?
      data; //IL PUNTO INTERROGATIVO SIGNIFICA CHE IL CAMPO PUO ANCHE ESSERE NULL
  List<Section>? sezioniFiglie;
  List<PoolFunzionalita>?
      toolImplementati; //in Dart non ci sono wildcard: in Java avrei dovuto scrive <? extends PoolFunzionalita>

  Section({required this.titolo, this.data});

  String get getTitolo => this.titolo;

  List<Section>? getSezioniFiglie() {
    return this.sezioniFiglie;
  }

  List<PoolFunzionalita>? getToolImplementati() {
    return this.toolImplementati;
  }

  @override
  Future<Section?> aggiungiSezione(BuildContext context, String titolo) async {
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
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

                            print("aggiunta della sezione alle sezioni figlie");
                            print("sezioniFiglie prima dell'aggiunta: $sezioniFiglie");
                            sezioniFiglie ??= []; //Gli operatori ?? sono utilizzati per fornire un valore di fallback nel caso in cui il valore a sinistra sia null
                            sezioniFiglie!.add(nuovaSezione); //L'operatore ! è utilizzato per indicare al compilatore che una variabile non sarà mai nulla.
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






    //poi bisogna fare un override di ogni funzione presente nell'interfaccia, PER IMPLEMENTARNE IL CORPO QUI
}
=======
    showDialog(
      context: context,
      builder: (context) {
        String nuovoTitolo = '';

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
              onPressed: () {
                if (nuovoTitolo.isNotEmpty) {
                  Section nuovaSezione = Section(titolo: nuovoTitolo);
                  sezioniFiglie?.add(
                      nuovaSezione); //metti'?' perché è un campo potenzialmente null
                  Navigator.of(context).pop(nuovaSezione);
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  //poi bisogna fare un override di ogni funzione presente nell'interfaccia, PER IMPLEMENTARNE IL CORPO QUI
}
>>>>>>> Stashed changes
