import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/todo_provider.dart';
import 'package:todo_app/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    todos = context.watch<TodoProvider>().todoList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            subtitle:
                Text(todos[index].desc ?? 'No description'), // Handle null case
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    updateDialog(context, todos[index]);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodoProvider>().deleteTodo(todos[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Delete todo successfully",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cDesc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () async {
                  var todo = Todo(
                    title: cTitle.text,
                    desc: cDesc.text.isNotEmpty ? cDesc.text : 'No description',
                    description: '',
                    isChecked: '',
                  );
                  context.read<TodoProvider>().addTodo(todo);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[900],
                      content: const Text(
                        "Todo added successfully",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        );
      },
    );
  }

  Future<dynamic> updateDialog(BuildContext context, Todo todo) {
    cTitle.text = todo.title;
    cDesc.text = todo.desc ?? ''; // Handle null case
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cTitle,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cDesc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  var newTodo = Todo(
                    title: cTitle.text,
                    desc: cDesc.text.isNotEmpty ? cDesc.text : '',
                    description: '',
                    isChecked: '',
                  );
                  context.read<TodoProvider>().updateTodo(todo, newTodo);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green[900],
                      content: const Text(
                        "Todo updated successfully",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Update')),
          ],
        );
      },
    );
  }
}
