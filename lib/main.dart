import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Todo app',
    home: MyApp(),
  ));
}

class Todo {
  String todo;

  Todo(this.todo);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    List<Todo> todos = [
      Todo('Learn Flutter'),
      Todo('Read a book'),
      Todo('Grocery shopping'),
      Todo('Cook dinner'),
      Todo('Do the dishes'),
      Todo('Vacuum the floors'),
    ];

    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('TIG333 TODO'),
          backgroundColor: Colors.grey,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        ),
        body:
            ListView(children: todos.map((todo) => _item(todo.todo)).toList()),
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

  Widget _item(String todo) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.square_outlined)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo,
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.clear_outlined)),
            ]),
        Padding(padding: EdgeInsets.all(5)),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}

class OtherView extends StatelessWidget {
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
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
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
