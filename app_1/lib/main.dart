import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';  // Certifique-se de que o caminho está correto

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyTaskApp(),
    ),
  );
}

class MyTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: provider.tasks.map((task) => _taskItem(context, task, provider)).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _taskItem(BuildContext context, String task, TaskProvider provider) {
    return ListTile(
      title: Text(task),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => provider.removeTask(task),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    final TextEditingController _taskController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new task'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Enter task here'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).addTask(_taskController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}
