import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

enum FilterValue { all, done, undone }

String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
String KEY = '74242629-8342-4db7-b446-5f9163e6541b';

class MyState extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  FilterValue _selectedFilter = FilterValue.all;

  FilterValue get selectedFilter => _selectedFilter;

  Future<void> addTodo(String title, bool checked) async {
    Todo todo = (Todo(title, checked));
    await http.post(Uri.parse('$ENDPOINT/todos?key=$KEY'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(todo.toJson()));
    fetchTodos();
  }

  void checkTask(Todo todo) async {
    await http.put(Uri.parse('$ENDPOINT/todos/${todo.id}?key=$KEY'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'title': todo.task, 'done': todo.ischecked = !todo.ischecked}));
    fetchTodos();
  }

  void removeTask(Todo todo) async {
    await http.delete(Uri.parse('$ENDPOINT/todos/${todo.id}?key=$KEY'));
    fetchTodos();
  }

  //hämta alla todos från backend api
  Future<List<Todo>> getTodos() async {
    http.Response response =
        await http.get(Uri.parse('$ENDPOINT/todos?key=$KEY'));
    String body = response.body;
    final List<dynamic> todoList = jsonDecode(body);
    return todoList.map((json) => Todo.fromJson(json)).toList();
  }

  void fetchTodos() async {
    var todos = await getTodos();
    _todos = todos;
    notifyListeners();
  }

  void setSelectedFilter(FilterValue selectedFilter) {
    _selectedFilter = selectedFilter;
    print(_selectedFilter);
  }
}
