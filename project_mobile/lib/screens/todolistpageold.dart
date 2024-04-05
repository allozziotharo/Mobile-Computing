
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
/////////////////////////////////////////////////////////////////////////////////

//CLASSE DELLA SINGOLA VOCE DELLA TO-DO LIST
class Task{
  bool? isDone;
  String task;
  int? priority;

//costruttore Task item
  Task({
    required this.task,
    this.isDone = false,
    this.priority = null,
  });


  /*
  TRASFORMA (DESERIALIZZAZIONE) UNA STRINGA DI JSON IN ISTANZA OGGETTO
  E' UN COSTRUTTORE
  CHE PRENDE UNA MAPPA CON ENTRIES DI OGGETTI JSONati
  CODIFICATI DA STRINGHE
  */
  Task.fromJson(Map<String, dynamic> json):
    isDone = json['isDone'],
    task = json['task'],
    priority = json['priority'];

    
  /*
  QUESTO METODO FA INVECE IL CONTRARIO
  CIOE' JSONizza L'ISTANZA
  IN UN OGGETTO JSON
  CODIFICATO DA STRINGHE
  */
  Map<String, dynamic> toJson() {
    return {
      'isDone': isDone,
      'task': task,
      'priority': priority,
    };
  }


}


///---------------------------------------------------------------

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

///----------------------------------------------------------------

class _ToDoListPageState extends State<ToDoListPage> {


  //chiave della animated list
  final listKey = GlobalKey<AnimatedListState>();

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();

    loadTasksList();
    //i dati vengono ora accompagnati dai cambiamenti di stato
  }



  /*
  ESATTO CONTRARIO DI initState
  viene chiamato quando il widget viene rimosso dal widget tree
  FALSE FRIEND: "dispose" significa "smaltire"
  */

  //SALVATAGGIO TASK IN LOCALE
  Future<void> saveTasksList() async {
    SharedPreferences data = await SharedPreferences.getInstance(); //chiamata statica al metodo che ti fa prendere i dati
    List<String> jsonEncodedData = tasks.map((task) => jsonEncode(task.toJson())).toList(); //invocazione CODIFICA toJson
    data.setStringList('tasks', jsonEncodedData); //metodo persistenza su locale

  }


  //CARICAMENTO DATI DA JSON
Future<void> loadTasksList() async {
  final SharedPreferences data = await SharedPreferences.getInstance();
  final List<String>? jsonDecodedData = data.getStringList('tasks');
  if (jsonDecodedData != null) {
    tasks = jsonDecodedData.map((jsonString) => Task.fromJson(json.decode(jsonString))).toList();
    print('Loaded ${tasks.length} tasks from shared preferences');
    setState(() {});
  } else {
    print('No tasks found in shared preferences');
  }
}



  @override
  Widget build(BuildContext context) {

//    loadTasksList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTUAL TASKS'),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: tasks.length,
        itemBuilder: (context, index, animation) {
          Task task = tasks[index];
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

void insertTask(String task, int? priority) {
  final newTask = Task(task: task, priority: priority);
  // Add the new task to the end of the list
  tasks.add(newTask);
  // Notify the AnimatedList of the insertion at the correct index
  listKey.currentState!.insertItem(0, duration: Duration(milliseconds: 250));
  // Persist the updated list of tasks
  saveTasksList();
  print('Saved ${tasks.length} tasks to shared preferences');
}

  void removeTask(int index) {
    final removedTask = tasks[index];
    tasks.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => _ToDoListWidget(
        task: removedTask,
        animation: animation,
        onClicked: () {},
      ),
      duration: Duration(milliseconds: 250),
    );
    
    setState(() {saveTasksList();}); //questo setState serve a fare il refresh della pagina
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
                    insertTask(data,  priority);

                    Navigator.of(context).pop();
                  },
                ), 
          ],
        );
      }
    );
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
          value: widget.task.isDone,
          onChanged: (newVal) {
            setState(() {
              widget.task.isDone = newVal;
            });
          },
        ),
              title: 
          Text(
            widget.task.task,
            style: TextStyle(
              fontSize: 28,
              color: Color.fromARGB(255, 6, 5, 5),
              decoration: widget.task.isDone == true? TextDecoration.lineThrough : null,
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




/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define the Task class
class Task {
  bool? isDone;
  String task;
  int? priority;

  Task({
    required this.task,
    this.isDone = false,
    this.priority,
  });

  Task.fromJson(Map<String, dynamic> json)
      : isDone = json['isDone'],
        task = json['task'],
        priority = json['priority'];

  Map<String, dynamic> toJson() {
    return {
      'isDone': isDone,
      'task': task,
      'priority': priority,
    };
  }
}

// Define the ToDoListPage widget
class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasksList();
  }

 Future<void> loadTasksList() async {
  final SharedPreferences data = await SharedPreferences.getInstance();
  final List<String>? jsonDecodedData = data.getStringList('tasks');
  if (jsonDecodedData != null) {
    tasks = jsonDecodedData.map((jsonString) => Task.fromJson(json.decode(jsonString))).toList();
    print('Loaded ${tasks.length} tasks from shared preferences');
    setState(() {}); // Trigger a rebuild after loading tasks
  } else {
    print('No tasks found in shared preferences');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ACTUAL TASKS'),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: listKey,
        initialItemCount: tasks.length,
        itemBuilder: (context, index, animation) {
          Task task = tasks[index];
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

  void insertTask(String task, int? priority) {
    final newTask = Task(task: task, priority: priority);
    tasks.add(newTask); // Correctly adds the new task to the end of the list
    int insertIndex = tasks.length - 1; // Should be the correct index for the new item
    listKey.currentState!.insertItem(insertIndex, duration: Duration(milliseconds: 250)); // Insert the new item into the AnimatedList
    saveTasksList();
    print('Saved ${tasks.length} tasks to shared preferences');
}

  void removeTask(int index) {
    final removedTask = tasks[index];
    tasks.removeAt(index);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => _ToDoListWidget(
        task: removedTask,
        animation: animation,
        onClicked: () {},
      ),
      duration: Duration(milliseconds: 250),
    );
    setState(() {
      saveTasksList();
    });
  }

  void saveTasksList() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    List<String> jsonEncodedData = tasks.map((task) => jsonEncode(task.toJson())).toList();
    data.setStringList('tasks', jsonEncodedData);
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
                  if (value == '0') {
                    priority = 0;
                  } else {
                    priority = int.parse(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'insert priority from 1 to 5 (otherwise it will be 0)',
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
      },
    );
  }
}

// Define the _ToDoListWidget widget
class _ToDoListWidget extends StatefulWidget {
  final Task task;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  _ToDoListWidget({
    required this.task,
    required this.animation,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  _ToDoListWidgetState createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<_ToDoListWidget> {
  @override
  Widget build(BuildContext context) => SizeTransition(
        sizeFactor: widget.animation,
        child: _buildItem(),
      );

  Widget _buildItem() => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _getColorByPriority(widget.task.priority),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Checkbox(
            value: widget.task.isDone,
            onChanged: (newVal) {
              setState(() {
                widget.task.isDone = newVal;
              });
            },
          ),
          title: Text(
            widget.task.task,
            style: TextStyle(
              fontSize: 28,
              color: Color.fromARGB(255, 6, 5, 5),
              decoration: widget.task.isDone == true ? TextDecoration.lineThrough : null,
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

  Color _getColorByPriority(int? priority) {
    switch (priority) {
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
  }
}
*/