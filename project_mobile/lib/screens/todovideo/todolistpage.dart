import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_mobile/screens/todovideo/task.dart';
///---------------------------------------------------------------

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

///----------------------------------------------------------------

class _ToDoListPageState extends State<ToDoListPage> {

  List<Task> list = List<Task>();
  SharedPreferences sharedPreferences;
  final listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTUAL TASKS'),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: list.length,
        itemBuilder: (context, index, animation) {
          Task task = list[index];
          return _ToDoListWidget(
            task: task,
            animation: animation,
            onClicked: () => removeTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => readData(),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }


  initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

  }

  void setCompleteness(Task item) {
    setState((){
      item.complete = !item.complete;
    });
    saveData();
  }
/*
  void addTask(Task item) {
    list.add(item);
    saveData();
  }
*/
  void insertTask(String title, int? priority) {
    final newTask = Task(title: title, priority: priority);
    // Add the new task to the end of the list
    list.add(newTask);
    // Notify the AnimatedList of the insertion at the correct index
    listKey.currentState!.insertItem(0, duration: Duration(milliseconds: 250));
    // Persist the updated list of tasks
    saveData();
    print('Saved ${list.length} tasks to shared preferences');
  }

  /*
  void editTask(Task item, String title) {
    item.title = title;
    saveData();
  }
  */

  /*
  void removeTask(Task item) {
    list.remove(item);
    if(list.isEmpty) setState(() {});
    saveData();
  }
  */
  void removeTask(int index) {
    final removedTask = list[index];
    list.removeAt(index);
    listKey.currentState!.removeItem(
      index,
          (context, animation) => _ToDoListWidget(
        task: removedTask,
        animation: animation,
        onClicked: () {},
      ),
      duration: Duration(milliseconds: 250),
    );

    saveData();
  }


  void readData() {
    String data = "";
    int? priority;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('task creation'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    data = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'type your task here',
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if(value == 0) priority = 0;
                    else priority = int.parse(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'insert priority from 1 to 5 (otherwise it will be 0)', //TODO: non c'entra e va fittato
                  ),
                ),
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
                  insertTask(data, priority);

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}

void saveData() {
    List<String> spList = list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    list = spList.map((item) => Task.fromMap(json.decode(item))).toList();
    setState(() {});
  }



}



class _ToDoListWidget extends StatefulWidget {
  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();


  final Task task;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  _ToDoListWidget(
      {required this.task,
        required this.animation,
        this.onClicked,
        Key? key});

}

class _ToDoListWidgetState extends State<_ToDoListWidget> {



  @override
  Widget build(BuildContext context) => SizeTransition(
    sizeFactor: widget.animation,
    child: BuildItem(),
  );

  Widget BuildItem() => Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: () {
        switch(widget.task.priority) {
          case 0:
            return Colors.transparent;
          case 1:
            return Color.fromARGB(66, 76, 175, 79);
          case 2:
            return Colors.green;
          case 3:
            return Color.fromARGB(255, 217, 255, 0);
          case 4:
            return Colors.orange;
          case 5:
            return const Color.fromARGB(255, 146, 38, 31);
          default:
            return Colors.transparent;
        }
      }(),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: Checkbox(
        value: widget.task.complete,
        onChanged: (newVal) {
          setState(() {
            widget.task.complete = newVal;
          });
        },
      ),
      title:
      Text(
        widget.task.title,
        style: TextStyle(
          fontSize: 28,
          color: Color.fromARGB(255, 6, 5, 5),
          decoration: widget.task.complete == true? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
          size: 32,
        ),
        onPressed: widget.onClicked,
      ),
    ),
  );
}

