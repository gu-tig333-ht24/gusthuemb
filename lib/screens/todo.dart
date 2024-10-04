import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state.dart';

/// [TodoView] renders an input field [_inputField] to be able to add a single task.
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
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
          title: Text('Check It',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0))),
          backgroundColor: const Color.fromARGB(200, 247, 227, 156)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Padding(padding: EdgeInsets.only(left: 20, right: 20)),
          _inputField(context, textEditingController),
          _addButton(context, textEditingController),
        ],
      ),
    );
  }
}

Widget _inputField(BuildContext context, textEditingController) {
  return Center(
    child: Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 2)
      ]),
      height: 50,
      width: 350,
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            labelText: 'Got something to check?',
            focusColor: Colors.black),
        controller: textEditingController,
      ),
    ),
  );
}

Widget _addButton(BuildContext context, textEditingController) {
  return Row(
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
          style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.black))),
    ],
  );
}
