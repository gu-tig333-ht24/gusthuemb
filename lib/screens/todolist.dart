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
        appBar: AppBar(
            title: Text('TIG333 TODO'),
            backgroundColor: Colors.grey,
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                      value: FilterValue.all,
                      child: Text(FilterValue.all.name)),
                  PopupMenuItem(
                      value: FilterValue.done,
                      child: Text(FilterValue.done.name)),
                  PopupMenuItem(
                      value: FilterValue.undone,
                      child: Text(FilterValue.undone.name))
                ],
                onSelected: (FilterValue value) {
                  context.read<TodoState>().setSelectedFilter(value);
                },
                //[IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
              ),
            ]),
        body: ListView(
            children: todos.map((todo) => _listItem(todo, context)).toList()),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TodoView()));
          },
          icon: Icon(Icons.add_circle),
          iconSize: 50,
        ),
      ),
    );
  }

  Widget _listItem(Task todo, BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<TodoState>().checkTask(todo);
                  },
                  icon: Icon(todo.ischecked
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_outlined)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.task,
                      style: TextStyle(
                          fontSize: 28,
                          decoration: todo.ischecked
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
        Padding(padding: EdgeInsets.all(5)),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
