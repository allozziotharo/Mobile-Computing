//materiale standard
import 'package:flutter/material.dart';
//import per usare route
//import 'package:project_mobile/route/route.dart' as route;

class ListItem {
  //classe del singolo elemento della lista
  final String esame; //attributi dell'oggetto
  final int voto;

  //costruttore (non possono essere assenti i parametri)
  const ListItem({required this.esame, required this.voto});
}

//la lista che contiene gli elementi
final List<ListItem> listItems = [
  ListItem(esame: 'ASD', voto: 30),
  ListItem(esame: 'FDA', voto: 29),
  ListItem(esame: 'POO', voto: 28),
  ListItem(esame: 'RO', voto: 27),
];

//questa classe costruisce il widget che viene visualizzato
class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListItemWidget(
      {required this.item,
      required this.onClicked,
      required this.animation,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: animation,
        child: BuildItem(),
      );

  Widget BuildItem() => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.lime,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.deepOrange,
            child: Text.rich(
              TextSpan(
                text: item.voto.toString(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          title: Text(
            item.esame,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: const Color.fromARGB(255, 54, 86, 244),
              size: 32,
            ),
            onPressed: onClicked,
          ),
        ),
      );
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final listKey = GlobalKey<AnimatedListState>();
  //tipo della lista          //da dove li prende
  final List<ListItem> items = List.from(listItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('prova lista'),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) => ListItemWidget(
          item: items[index],
          animation: animation,
          onClicked: () => removeItem(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            readData(), //qui va aggiunto il metodo che lancia la procedura di aggiunta del nuovo el
      ),
      backgroundColor: Colors.grey,
    );
  }

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

  void readData() {
    String esame = '';
    int voto = 0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('inserisci esame e voto'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    esame = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'inserisci nome esame',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    voto = int.parse(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'inserisci voto esame',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Annulla'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Procedi'),
                onPressed: () {
                  insertItem(esame, voto);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void insertItem(String esame, int voto) {
    final newIndex = 0;
    final newItem = ListItem(esame: esame, voto: voto);
    items.insert(newIndex, newItem);
    listKey.currentState!
        .insertItem(newIndex, duration: Duration(milliseconds: 500));
  }
}
