import 'package:flutter/material.dart';
import 'package:snakes_and_ladders/screens/game_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
