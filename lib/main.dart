import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo{
  String todo;

  Todo(this.todo);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      home: Scaffold(
        appBar: AppBar(
          title: Text('TIG333 TODO'),
          backgroundColor: Colors.grey,
          actions: [IconButton(onPressed: () {}, 
          icon: Icon(Icons.more_vert))],
        ),
        body: Column(
          children: [
            _item('Read a book'),
            Divider(color: Colors.grey,),
            _item('Cook dinner'),
            Divider(color: Colors.grey,),
            _item('Do the dishes'),
            Divider(color: Colors.grey,),
            _item('Vacuum'),
            Divider(color: Colors.grey,),
            _item('Continue working on the to do app'),
            Divider(color: Colors.grey,),
            _item('Continue knitting'),
            Divider(color: Colors.grey,),
            _item('Buy a present'),
            Divider(color: Colors.grey,),
          ],
        ), 
        
    )
    );
  
  
}
  Widget _item(String todo) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.square_outlined)),
                Expanded( child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(todo, style: TextStyle(fontSize: 30),),
                  ],
                ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.clear_outlined)),]
            ); 
            
  }
}