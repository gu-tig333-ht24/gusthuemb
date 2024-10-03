import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state.dart';
import '../model.dart';
import 'todo.dart';

class TodoListView extends StatelessWidget {
  TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    var todos = context.watch<TodoState>().todos;

    return MaterialApp(
      title: 'Check It',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 239, 239, 239),
        appBar: AppBar(
            title: Text('Check It',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0))),
            backgroundColor: const Color.fromARGB(200, 247, 227, 156),
            actions: [_filterMenu(context)]),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                  children:
                      todos.map((todo) => _listItem(todo, context)).toList()),
            ),
          ],
        ),
        floatingActionButton: _addTodoButton(context),
      ),
    );
  }

  Widget _filterMenu(BuildContext context) {
    return PopupMenuButton(
      color: const Color.fromARGB(255, 249, 249, 249),
      icon: Icon(Icons.more_vert),
      itemBuilder: (context) => [
        PopupMenuItem(
            value: FilterValue.all, child: Text(FilterValue.all.name)),
        PopupMenuItem(
            value: FilterValue.done, child: Text(FilterValue.done.name)),
        PopupMenuItem(
            value: FilterValue.undone, child: Text(FilterValue.undone.name))
      ],
      onSelected: (FilterValue value) {
        context.read<TodoState>().setSelectedFilter(value);
      },
    );
  }

  Widget _listItem(Task todo, BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2)
          ]),
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 50,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
                onPressed: () {
                  context.read<TodoState>().checkTask(todo);
                },
                icon: Icon(todo.isChecked
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_outlined)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(2)),
                  Text(
                    todo.task,
                    style: TextStyle(
                        fontSize: 25,
                        decoration: todo.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  context.read<TodoState>().removeTask(todo);
                },
                icon: Icon(Icons.clear_outlined)),
          ]),
        ),
      ],
    );
  }
}

Widget _addTodoButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TodoView()));
    },
    icon: Icon(Icons.add_circle),
    iconSize: 50,
    tooltip: 'Add To-do',
  );
}
