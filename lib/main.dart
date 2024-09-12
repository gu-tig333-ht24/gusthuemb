import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.square_outlined)),
                Expanded( child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Read a book', style: TextStyle(fontSize: 30),),
                  ],
                ),
                ),
                IconButton(onPressed: () {print('remove');}, icon: Icon(Icons.clear_outlined)),]
            ),
            Divider(color: Colors.grey,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.square_outlined)),
                Expanded( child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Read a book', style: TextStyle(fontSize: 30),),
                  ],
                ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.clear_outlined)),]
            ),
          ],
        ), 
        
    )
    );
}
}