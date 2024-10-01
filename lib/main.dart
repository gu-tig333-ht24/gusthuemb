import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state.dart';
import 'screens/todolist.dart';

void main() {
  TodoState state = TodoState();

  // hämta listan av todos
  state.fetchTodos();

  runApp(
    ChangeNotifierProvider(
        create: (context) => state,
        child: MaterialApp(
          title: 'Check It',
          home: TodoListView(),
        )),
  );
}
