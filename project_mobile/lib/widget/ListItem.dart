//materiale standard
import 'package:flutter/material.dart';
//import per usare route

class ListItem {
  //classe del singolo elemento della lista
  final String esame; //attributi dell'oggetto
  final int voto;
  final String data;

  //costruttore (non possono essere assenti i parametri)
  ListItem({
    required this.esame,
    required this.voto,
    required this.data,
  });

  ListItem.fromMap(Map<String, dynamic> map)
      : esame = map['esame'],
        voto = map['voto'],
        data = map['data'];

  Map<String, dynamic> toMap() {
    return {
      'esame': esame,
      'voto': voto,
      'data': data,
    };
  }
}

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
          color: Colors.deepPurple,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Text.rich(
              TextSpan(
                text: item.voto.toString(),
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          ),
          title: Column(
            children: [
              Text(
                item.esame,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              Text(
                item.data,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 32,
            ),
            onPressed: onClicked,
          ),
        ),
      );
}
