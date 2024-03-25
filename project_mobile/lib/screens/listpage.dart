//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/ListItem.dart';
import 'package:project_mobile/widget/degreeGraph/graph.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //per far vedere cosa è stato selezionato nel datepicker
  TextEditingController _dateController = TextEditingController();

  //chiave della animated list
  final listKey = GlobalKey<AnimatedListState>();

  //tipo della lista
  final List<ListItem> items = [];

  //lista che deve contenere i voti degli esami
  List<double> degree = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CAREER'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //WIDGET PER MEDIA E CFU
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("CFU: 0"),
                  Divider(),
                  Text("MEDIA: 0.00"),
                ],
              )),
          //grafico
          SizedBox(
            height: 300,
            child: MyGraph(
              degreeList: degree,
            ),
          ),
          //la lista va sotto
          Expanded(
            child: AnimatedList(
              key: listKey,
              initialItemCount: items.length,
              itemBuilder: (context, index, animation) => ListItemWidget(
                item: items[index],
                animation: animation,
                onClicked: () => removeItem(index),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            readData(), //qui va aggiunto il metodo che lancia la procedura di aggiunta del nuovo el
      ),
      backgroundColor: Colors.white,
    );
  }
  /************************************/

  //funzione che rimuove un list item invocata dal cestino
  void removeItem(int index) {
    final removedItem = items[index];
    items.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => ListItemWidget(
        item: removedItem,
        animation: animation,
        onClicked: () {},
      ),
      duration: Duration(milliseconds: 400),
    );
  }
  /********************************************/

  //funzione che si occupa dell'interazione con l'utente invocata tramite il floating action button
  void readData() {
    String data = "";
    String esame = "";
    int voto = 0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('insert exam data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    esame = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'insert exam name',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    voto = int.parse(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'insert exam degree',
                  ),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'DATE',
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_today),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025));
                    if (picked != null) {
                      setState(() {
                        _dateController.text = picked.toString().split(" ")[0];
                        data = picked.toString().split(" ")[0];
                      });
                    }
                  },
                )
              ],
            ),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('PROCEED'),
                onPressed: () {
                  insertItem(esame, voto, data);
                  _dateController.text = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  /***************************************************/

  //funzione che chiama il costruttore di list item e lo inserisce nella lista
  void insertItem(String esame, int voto, String data) {
    final newIndex = 0;
    final newItem = ListItem(esame: esame, voto: voto, data: data);
    degree.add(double.parse(newItem.voto.toString()));
    items.insert(newIndex, newItem);
    listKey.currentState!
        .insertItem(newIndex, duration: Duration(milliseconds: 500));
  }
  /*****************************************************/
}
