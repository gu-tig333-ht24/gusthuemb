import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state.dart';

class TodoView extends StatefulWidget {
  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  TextEditingController? textEditingController;

  _TodoViewState() {
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
                      .read<TodoState>()
                      .addTodo(textEditingController!.text, false);
                  Navigator.pop(context);
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
