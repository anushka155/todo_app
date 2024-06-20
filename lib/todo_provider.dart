import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_model.dart';

class TodoProvider with ChangeNotifier {
  final String _key = "todos";
  List<Todo> _todoList = [];

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString(_key);

    if (todosString != null) {
      final List<dynamic> decodedJson = jsonDecode(todosString) as List;
      var list = decodedJson.map((json) => Todo.fromMap(json)).toList();
      _todoList = list;
      notifyListeners();
    }
  }

  Future<void> saveTodos(List<Todo> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedJson =
        jsonEncode(notes.map((todo) => todo.toMap()).toList());
    await prefs.setString(_key, encodedJson);
    loadTodos();
  }

  Future<void> addTodo(Todo note) async {
    _todoList.add(note);
    await saveTodos(_todoList);
  }

  Future<void> deleteTodo(Todo todo) async {
    _todoList.remove(todo);
    await saveTodos(_todoList);
  }

  void updateTodo(Todo oldData, Todo newData) {
    var index = _todoList.indexOf(oldData);
    _todoList.removeAt(index);
    _todoList.insert(index, newData);
    saveTodos(_todoList);
  }

  List<Todo> get todoList => _todoList;
}
