//materiale standard
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {

  //chiave della animated list
final listKey = GlobalKey<AnimatedListState>();

final List<Task> tasks = [];



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

  void insertTask(String task, int ?priority){
    final newTask = Task(task: task, priority: priority);
    tasks.insert(0, newTask);
    listKey.currentState!.insertItem(0, duration: Duration(milliseconds: 250));
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
    setState(() {}); //questo setState serve a fare il refresh della pagina
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
                    setState(() {});
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



