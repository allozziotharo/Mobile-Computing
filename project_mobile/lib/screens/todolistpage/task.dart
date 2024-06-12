//CLASSE DELLA SINGOLA VOCE DELLA TO-DO LIST
class Task {
  bool complete;
  String title;
  int? priority;

  // Main constructor
  Task({this.title = '', this.complete = false, this.priority});

  // Named constructor for creating a task with a title
  Task.withTitle(this.title) : complete = false, priority = null;

  // Named constructor for creating a task from a Map
  Task.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        complete = map['complete'],
        priority = map['priority'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'complete': complete,
      'priority': priority,
    };
  }

  
}
