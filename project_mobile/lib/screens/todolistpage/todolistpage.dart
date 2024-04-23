import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_mobile/screens/todolistpage/task.dart';
import 'package:project_mobile/preferences/todolist_pref.dart';
///---------------------------------------------------------------

class ToDoListPage extends StatefulWidget {
/*
  List<Task> list = [];
  SharedPreferences? sharedPreferences;
  final listKey = GlobalKey<AnimatedListState>();
*/
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

///----------------------------------------------------------------

class _ToDoListPageState extends State<ToDoListPage> {

  List<Task> list = [];
  late SharedPreferences sharedPreferences;
  final listKey = GlobalKey<AnimatedListState>();


  @override
  Widget build(BuildContext context) {
    //setState((){}); 
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
            onClicked: () => removeTask(index), // Pass the callback here
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
    super.initState();
    list = ToDoListPreferences.getToDoList();
   // initSharedPreferences();
  }
/*
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(); // Call loadData again to ensure data is refreshed.
  }*/

  /*
  void initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }
  */

  void toggleTaskCompleteness(int index) {
  setState(() {
    list[index].complete = !list[index].complete;
  });
  ToDoListPreferences.setToDoList(list); // Save the updated list
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
    ToDoListPreferences.setToDoList(list);
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
    ToDoListPreferences.setToDoList(list);
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

/*
  void saveData() {
      List<String> spList = widget.list.map((item) => json.encode(item.toMap())).toList();
      widget.sharedPreferences!.setStringList('list', spList);
    }

  void loadData() {
    List<String>? spList = widget.sharedPreferences!.getStringList('list');
    if (spList != null) widget.list = spList.map((item) => Task.fromMap(json.decode(item))).toList();
    else widget.list = [];
    setState(() {});
  }
  */

}

class _ToDoListWidget extends StatefulWidget {
  final Task task;
  final Animation<double> animation;
  final VoidCallback? onClicked; // Ensure this is nullable

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
    child: BuildItem(),
  );

  Widget BuildItem() => Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: () {
        switch(widget.task.priority) {
          case 1:
            return Color.fromARGB(66, 63, 147, 66);
          case 2:
            return const Color.fromARGB(255, 38, 91, 39);
          case 3:
            return Color.fromARGB(255, 195, 172, 0);
          case 4:
            return const Color.fromARGB(255, 206, 124, 0);
          case 5:
            return Color.fromARGB(255, 213, 68, 58);
          default:
            return  Color.fromARGB(66, 63, 147, 66);
        }
      }(),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: Checkbox(
        value: widget.task.complete,
        onChanged: (bool? newValue) {
          if (newValue != null) {
            setState((){
              widget.task.complete = newValue; // Call the passed callback function})
            });
          }
        },
      ),
      title:
      Text(
        widget.task.title,
        style: TextStyle(
          fontSize: 28,
          color: Colors.white,
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



