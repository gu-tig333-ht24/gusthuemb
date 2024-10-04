import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

enum FilterValue { all, done, undone }

///[TodoState] holds the state of tasks and selected filter. 
///Any change to the state are reflected in the views.
class TodoState extends ChangeNotifier {

  final String _key = '74242629-8342-4db7-b446-5f9163e6541b';
  String get key => _key;

  final String _endpoint = 'https://todoapp-api.apps.k8s.gu.se';
  String get endpoint => _endpoint; 


  List<Task> _todos = [];
  List<Task> get todos {
    if (selectedFilter == FilterValue.all) {
      return _todos;
    }
    else if (selectedFilter == FilterValue.done) {
      return _todos.where((todo) => todo.isChecked == true).toList();
    }
    else if (selectedFilter == FilterValue.undone){
      return _todos.where((todo) => todo.isChecked == false).toList();
    }
    return _todos;}

  FilterValue _selectedFilter = FilterValue.all;
  FilterValue get selectedFilter => _selectedFilter;

  Future<void> addTodo(String title, bool checked) async {
    Task todo = (Task(title, checked));
    await http.post(Uri.parse('$_endpoint/todos?key=$_key'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(todo.toJson()));
    fetchTodos();
  }

  void checkTask(Task todo) async {
    await http.put(Uri.parse('$_endpoint/todos/${todo.id}?key=$_key'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'title': todo.task, 'done': todo.isChecked = !todo.isChecked}));
    fetchTodos();
  }

  void removeTask(Task todo) async {
    await http.delete(Uri.parse('$_endpoint/todos/${todo.id}?key=$_key'));
    fetchTodos();
  }

  Future<List<Task>> getTodos() async {
    http.Response response =
        await http.get(Uri.parse('$_endpoint/todos?key=$_key'));
    String body = response.body;
    final List<dynamic> todoList = jsonDecode(body);
    return todoList.map((json) => Task.fromJson(json)).toList();
  }

  void fetchTodos() async {
    var todos = await getTodos();
    _todos = todos;
    notifyListeners();
  }

  void setSelectedFilter(FilterValue selectedFilter) {
    _selectedFilter = selectedFilter;
    notifyListeners();
  }
}
