import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyState extends ChangeNotifier {
  List<Todo> _todos = [
    Todo('Learn Flutter', false),
    Todo('Read a book', true),
    Todo('Cook dinner', false),
    Todo('Do the dishes', false),
  ];

  List<Todo> get todos => _todos;

  void addTodo(String title, bool checked) {
    todos.add(Todo(title, checked));
    notifyListeners();
  }

  void checkTask(Todo todo) {
    todo.ischecked = !todo.ischecked;
    notifyListeners();
  }

  void removeTask(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

}

void main() {
  MyState state = MyState();
  runApp(
    ChangeNotifierProvider(
        create: (context) => state,
        child: MaterialApp(
          title: 'Todo app',
          home: MyApp(),
        )),
  );
}


class Todo {
  String task;
  bool ischecked;

  Todo(this.task, this.ischecked);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var todos = context.watch<MyState>().todos;

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('TIG333 TODO'),
          backgroundColor: Colors.grey,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body:
            ListView(children: todos.map((todo) => _item(todo, context)).toList()),
        floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OtherView()));
          },
          icon: Icon(Icons.add_circle),
          iconSize: 50,
        ),
      ),
    );
  }

  Widget _item(Todo todo, BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: () {context.read<MyState>().checkTask(todo);}, icon: Icon(todo.ischecked?Icons.check_box_outlined:Icons.check_box_outline_blank_outlined)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.task,
                      style: TextStyle(fontSize: 28, decoration: todo.ischecked?TextDecoration.lineThrough:TextDecoration.none),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {context.read<MyState>().removeTask(todo);}, icon: Icon(Icons.clear_outlined)),
            ]),
        Padding(padding: EdgeInsets.all(5)),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

class OtherView extends StatefulWidget {
  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView> {
  TextEditingController? textEditingController;

  _OtherViewState() {
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIG333 TODO'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Padding(padding: EdgeInsets.only(left: 20, right: 20)),
          Center(
            child: Container(
              height: 100,
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'What are you going to do?'),
                controller: textEditingController,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                context.read<MyState>().addTodo(textEditingController!.text, false);
      

                },
                icon: Icon(Icons.add),
                label: Text('ADD'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
