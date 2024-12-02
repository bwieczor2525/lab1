import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista_do_wykonania',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> _todoItems = [];
  TextEditingController _controller = TextEditingController();
  int? _editingIndex;

  void _addOrEditTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        if (_editingIndex == null) {
          _todoItems.add(TodoItem(title: _controller.text));
        } else {
          _todoItems[_editingIndex!].title = _controller.text;
          _editingIndex = null;
        }
      });
      _controller.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggleCompletion(int index) {
    setState(() {
      _todoItems[index].isCompleted = !_todoItems[index].isCompleted;
    });
  }

  void _editTask(int index) {
    setState(() {
      _controller.text = _todoItems[index].title;
      _editingIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista_do_wykonania'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.3),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Dodaj czynność',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_editingIndex == null ? Icons.add : Icons.save),
                  onPressed: _addOrEditTask,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todoItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 15,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
                    child: ListTile(
                      leading: Checkbox(
                        value: _todoItems[index].isCompleted,
                        onChanged: (bool? value) {
                          _toggleCompletion(index);
                        },
                      ),
                      title: Text(
                        _todoItems[index].title,
                        style: TextStyle(
                          decoration: _todoItems[index].isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editTask(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.blueAccent),
                            onPressed: () => _deleteTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});
}