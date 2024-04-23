import 'package:flutter/material.dart';
import 'package:project_mobile/preferences/list_pref.dart';
import 'package:project_mobile/widget/ListItem.dart';
import 'package:project_mobile/widget/degreeWidget/graph.dart';

class StatsPage extends StatefulWidget {
  final List<ListItem> items;
  StatsPage({required this.items});

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  final listKey = GlobalKey<AnimatedListState>();
  late final List<double> degree = [];

  @override
  void initState() {
    super.initState();
    item2int(ListPreferences.getListItem());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("stats"),
        centerTitle: true,
      ),
      body: Expanded(
        child: MyGraph(degreeList: degree),
      ),
    );
  }

  void item2int(List<ListItem> list) {
    for (var item in list) {
      degree.add(item.voto.toDouble());
    }
  }
}
