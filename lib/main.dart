import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/*
var url = Uri.https('todoapp-api.apps.k8s.gu.se', '/todos',
    {'key': '74242629-8342-4db7-b446-5f9163e6541b'});
*/

String ENDPOINT = 'https://todoapp-api.apps.k8s.gu.se';
String KEY = '74242629-8342-4db7-b446-5f9163e6541b';

enum FilterValue { all, done, undone }

class MyState extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  FilterValue _selectedFilter = FilterValue.all;

  FilterValue get selectedFilter => _selectedFilter;

  Future<void> addTodo(String title, bool checked) async {
    Todo todo = (Todo(title, checked));
    print(todo);
    await http.post(Uri.parse('$ENDPOINT/todos?key=$KEY'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(todo.toJson()));
    /*
    await http.post(url,
    headers: {
      "Content-Type": "application/json"
    },
    body: jsonEncode(todo.toJson()));
    */
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

void main() {
  MyState state = MyState();

  // hämta listan av todos
  state.fetchTodos();

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
  String? id;
  String task;
  bool ischecked;

  Todo(this.task, this.ischecked, [this.id]);

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(json['title'], json['done'], json['id']);
  }
  Map<String, dynamic> toJson() {
    return {
      "title": task,
      "done": ischecked,
    };
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var todos = context.watch<MyState>().todos;

    return MaterialApp(
      title: 'Flutter Demo',
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
                  context.read<MyState>().setSelectedFilter(value);
                },
                //[IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
              ),
            ]),
        body: ListView(
            children: todos.map((todo) => _item(todo, context)).toList()),

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
              IconButton(
                  onPressed: () {
                    context.read<MyState>().checkTask(todo);
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
                    context.read<MyState>().removeTask(todo);
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
                onPressed: () async {
                  await context
                      .read<MyState>()
                      .addTodo(textEditingController!.text, false);
                  Navigator.pop(context);
                  //context.read<MyState>().fetchTodos();
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
